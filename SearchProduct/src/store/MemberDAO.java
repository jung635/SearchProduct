package store;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	
	public Connection getConnection() throws Exception{

		//Context객체 생성
		Context init = new InitialContext();
		//DataSource 디비 연동 이름 불러오기
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/mysqlDB");//java:comp/env/까지 항상 공통적. 뒤로는 이름.
		//con= DataSource형태로 저장
		Connection con=ds.getConnection();
		return con;
		
		
		
	}

	//회원가입
	public void insertMember(MemberBean mb){
		
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		
		try{
			con=getConnection();
			
			sql = "insert into member(name, id, pass, email, address, phone, reg_date, postcode) values (?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getName());
			pstmt.setString(2, mb.getId());
			pstmt.setString(3, mb.getPass());
			pstmt.setString(4, mb.getEmail());
			pstmt.setString(5, mb.getAddress());
			pstmt.setString(6, mb.getPhone());
			pstmt.setTimestamp(7, mb.getReg_date());
			pstmt.setString(8, mb.getPostcode());
			
			pstmt.executeUpdate();
		}catch(Exception e){
			System.out.println("DB연결 실패"+e);
		}finally{
			//객체생성닫기
			try{
			con.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			
		}
		
	}
/*	//회원가입(스토어)
	public void insertStoreMember(StoreBean sb){
		
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		
		try{
			con=getConnection();
			
			sql = "insert into stores(name, address, id, pass, ad_id, email) values (?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, sb.getName());
			pstmt.setString(2, sb.getAddress());
			pstmt.setString(3, sb.getId());
			pstmt.setString(4, sb.getPass());
			pstmt.setString(5, sb.getAd_id());
			pstmt.setString(6, sb.getEmail());
			
			pstmt.executeUpdate();
		}catch(Exception e){
			System.out.println("DB연결 실패"+e);
		}finally{
			//객체생성닫기
			try{
			con.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			
		}
		
	}*/
	
	
	//아이디 중복확인
	
public boolean idDupCheck(String id){
		
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		boolean check=false;//아이디 중복
		try{
			con = getConnection();
			sql= "select * from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				return check;//아이디 중복
			}else if(rs.next()==false){
				check=true;//아이디 중복 안됨
				return check;
			}
			
		}catch(Exception e){
			System.out.println("DB연결 실패"+e);
			
		}finally{
			//객체생성닫기
			try{
			con.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		System.out.println(check);
		return check;
		
		
	}

	
		//아이디 비밀번호 비교
	public int idCheck(String id, String pass){
		
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String sql="";
		int check=1;//성공
		
		try{
			con = getConnection();

			
			sql = "select pass from member where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()){
				if(pass.equals(rs.getString(1))){
				}else{
					check=-1;//비밀번호 없음
				}
			}else{
				check=0;//아이디 없음
			}
	

			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
				con.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			if(pstmt!=null){
			try{
				pstmt.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			}
			if(rs!=null){
			try{
				rs.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			}
		}
		return check;
		
	}	
	
	
	//메일 보내기
	public void sendMail(List<String> list) throws MessagingException{
		
		final String id="sunju635";
		final String pass="Tjswn635*";
		int port=25;
		//String host="localhost";
		//String host="smtp.naver.com";
		String from=list.get(0);
		String to=list.get(1);
		String subject=list.get(2);
		String content=list.get(3);
		
		Properties props = new Properties();
		
		props.put("mail.stmp.starttls.enable","true");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.host", "127.0.0.1");
		props.put("mail.smtp.port", port);
		//
		//
		
		
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator(){
			protected PasswordAuthentication getPasswordAuthentication(){
				return new PasswordAuthentication(id, pass);
			}
		});
		session.setDebug(true);
		
		Message message = new MimeMessage(session);
		message.setFrom(new InternetAddress(from));
		message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
		message.setSubject(subject);
		message.setContent(content,"text/html; charset=EUC-KR");
		message.setText(content);
		
		Transport.send(message);
		System.out.println("E-mail successfully sent!");
	}
	
	
	/*	
	//회원정보수정
	public int updateMember(MemberBean mb,String changePass){
		//2단계 디비연결 => Connection con 객체 저장
		String dbUrl="jdbc:mysql://localhost:3306/jspdb2";
		String dbId = "jspid";
		String dbPass = "jsppass";
		Connection con = null;
		PreparedStatement pstmt=null;
		String sql="";
		int check = -1;
		try{
			//1단계 드라이버 로더
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(dbUrl, dbId, dbPass);
			sql = "select pass from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getId());
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()){
			if(mb.getPass().equals(rs.getString("pass"))){
			sql = "update member set pass=?, name=?, age=?, gender=?, email=? where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, changePass);
			pstmt.setString(2, mb.getName());
			pstmt.setInt(3, mb.getAge());
			pstmt.setString(4, mb.getGender());
			pstmt.setString(5, mb.getEmail());
			pstmt.setString(6, mb.getId());
			
			pstmt.executeUpdate();
			
			check=1;
			}else{
				check=0;//비밀번호 틀림
			}
			}
			
			
		}catch(Exception e){
			System.out.println("DB연결 실패"+e);
		}finally{
			//객체생성닫기
			try{
			con.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			
		}
		
		return check;
	}
	
	//회원삭제
	public void deleteMember(String id){

		//2단계 디비연결 => Connection con 객체 저장
		String dbUrl="jdbc:mysql://localhost:3306/jspdb2";
		String dbId = "jspid";
		String dbPass = "jsppass";
		Connection con = null;
		PreparedStatement pstmt=null;
		String sql="";
		try{
			//1단계 드라이버 로더
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(dbUrl, dbId, dbPass);
			sql = "delete from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			pstmt.executeUpdate();
		}catch(Exception e){
			System.out.println("DB연결 실패"+e);
		}finally{
			//객체생성닫기
			try{
			con.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			
		}
	}
	
	//로그인 정보
	public MemberBean infoMember(String id){

		//2단계 디비연결 => Connection con 객체 저장
		String dbUrl="jdbc:mysql://localhost:3306/jspdb2";
		String dbId = "jspid";
		String dbPass = "jsppass";
		
		Connection con = null;
		PreparedStatement pstmt=null;
		String sql="";
		MemberBean mb = null;
		ResultSet rs = null;
		
		try{
			mb = new MemberBean();
			//1단계 드라이버 로더
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(dbUrl, dbId, dbPass);
			con=getConnection();
			sql = "select * from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()){
				mb.setId(rs.getString("id"));
				mb.setPass(rs.getString("pass"));
				mb.setName(rs.getString("name"));
				mb.setReg_date(rs.getTimestamp("reg_date"));
				mb.setAge(rs.getInt("age"));
				mb.setGender(rs.getString("gender"));
				mb.setEmail(rs.getString("email"));
			}
			
			return mb;
			
		}catch(Exception e){
			System.out.println("DB연결 실패"+e);
		}finally{
			//객체생성닫기
			if(rs!=null){
				try{
					rs.close();
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			if(pstmt!=null){
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if(con!=null){
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
		}
		
		return null;
	}
	
	//로그인 정보
		public List<Object> listMember(){

			List<Object> list = new ArrayList<Object>();
			List<Object> list2 = new ArrayList<Object>();
			Connection con = null;
			PreparedStatement pstmt=null;
			String sql="";
			MemberBean mb = null;
			ResultSet rs = null;
			
			try{
				
	
				con=getConnection();
				sql = "select * from member";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while(rs.next()){
					mb = new MemberBean();
					list.add(rs.getString("id"));
					list.add(rs.getString("pass"));
					list.add(rs.getString("name"));
					list.add(rs.getTimestamp("reg_date"));
					list.add(rs.getInt("age"));
					list.add(rs.getString("gender"));
					list.add(rs.getString("email"));
					
					mb.setId(rs.getString("id"));
					mb.setPass(rs.getString("pass"));
					mb.setName(rs.getString("name"));
					mb.setReg_date(rs.getTimestamp("reg_date"));
					mb.setAge(rs.getInt("age"));
					mb.setGender(rs.getString("gender"));
					mb.setEmail(rs.getString("email"));
					list2.add(mb);
					
				}
				
				//return list;
				
			}catch(Exception e){
				System.out.println("DB연결 실패"+e);
			}finally{
				//객체생성닫기
				if(rs!=null){
					try{
						rs.close();
					}catch(Exception e){
						e.printStackTrace();
					}
				}
				if(pstmt!=null){
					try {
						pstmt.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				if(con!=null){
					try {
						con.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				
			}
			
			return list2;
		}
	*/
	

}
