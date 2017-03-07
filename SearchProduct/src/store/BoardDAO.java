package store;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;



public class BoardDAO {
	public Connection getConnection() throws Exception{

		//Context객체 생성
		Context init = new InitialContext();
		//DataSource 디비 연동 이름 불러오기
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/mysqlDB");//java:comp/env/까지 항상 공통적. 뒤로는 이름.
		//con= DataSource형태로 저장
		Connection con=ds.getConnection();
		return con;
		
		
		
	}
	
	//글 개수
	public int getListCount(){
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		int num=0;
		
		try{
			con=getConnection();
			sql="select count(num) from board";
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				num=rs.getInt(1);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
				con.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		return num;
	}
	
	//글 등록
	public void insertBoard(BoardBean bb){
		/*
		 디비연결
		 num게시판 글번호 구하기
		 sql insert
		 실행
		  */
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String sql="";
		int num=0;
		int readcount=0;
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con = getConnection();
			sql="select max(num) from board;";
			pstmt=con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				num=rs.getInt(1)+1;
			}
			
			sql = "insert into board(num, name, pass, subject,"
					+ " content, readcount,date, file)"
							+ " values(?,?,?,?,?,?,date_format(now(),'%Y-%m-%d'),?);";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, bb.getName());
			pstmt.setString(3, bb.getPass());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setInt(6, readcount);
			pstmt.setString(7, bb.getFile());
			
			pstmt.executeUpdate();
			
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
	}
	
	//글목록
	public List<Object> boardList(int start, int pageSize){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<Object> list = new ArrayList<Object>();
		BoardBean bb = null;
		try{
			
			Class.forName("com.mysql.jdbc.Driver");
			con=getConnection();
			
			sql = "select * from board order by num desc limit ?,?;";
			//sql = "select * from board where num>=? and num<=? group by re_ref order by re_ref desc, re_seq asc;";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			while(rs.next()){
				bb = new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setPass(rs.getString("pass"));
				bb.setSubject(rs.getString("subject"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setDate(rs.getTimestamp("date"));
				bb.setFile(rs.getString("file"));
				bb.setReadcount(rs.getInt("readcount"));
				
				list.add(bb);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
				con.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return list;
		
	}
	
	//글내용
	public BoardBean getDetail(int num){
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String sql = "";
		BoardBean bb = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con=getConnection();
			
			sql = "select * from board where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			if(rs.next()){
				bb = new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setFile(rs.getString("file"));
			}
			
		
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
				con.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		return bb;
	}
	
	//댓글내용
		public List<Object> getReDetail(int num){
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs = null;
			String sql = "";
			CommentBean cb = null;
			List<Object> relist = new ArrayList<Object>();
			try{
				con=getConnection();
				
				sql = "select * from comment where re_ref=? order by re_seq asc";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs=pstmt.executeQuery();
				while(rs.next()){
					cb = new CommentBean();
					cb.setName(rs.getString("name"));
					cb.setContent(rs.getString("content"));
					cb.setRe_lev(rs.getInt("re_lev"));
					cb.setRe_seq(rs.getInt("re_seq"));
					cb.setRe_ref(rs.getInt("re_ref"));
					
					relist.add(cb);
				}
				
			
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				try{
					con.close();
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			
			return relist;
		}
	
	//조회수 증가
	public void updateReadcount(int num){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql = "";
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con = getConnection();
			sql = "update board set readcount=readcount+1 where num=? ";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
				con.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			
		}
		
	}
	
	

	/*//글 쓴이 체크
	public boolean userCheck(int num, String pass){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql = "";
		ResultSet rs =null;
		boolean result = false;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con = getConnection();
			sql = "select pass from board where num=? ";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			
			if(rs.next()){
				if(rs.getString("pass").equals(pass)){
					result = true;
				}
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
				con.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			
		}
		
		return result;
		
		
	}*/
	//글 수정
	public int updateBoard(BoardBean bb){
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs =null;
		String sql = "";
		int check=-1;
		
		
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con = getConnection();
			sql = "select pass from board where num=? ";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, bb.getNum());
			rs=pstmt.executeQuery();
		
			if(rs.next()){
				if(rs.getString("pass").equals(bb.getPass())){
					check=1;
					sql = "update board set name=?, subject=?, content=? where num=? ";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1,bb.getName() );
					pstmt.setString(2, bb.getSubject());
					pstmt.setString(3, bb.getContent());
					pstmt.setInt(4, bb.getNum());
					pstmt.executeUpdate();
				}else{
					check=0;
				}
			}else{
				check=-1;
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
				con.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			
		}
		return check;
	}
	
	//글 삭제
	public int deleteBoard(int num, String pass){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql = "";
		ResultSet rs = null;
		int check = 1;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con = getConnection();
			sql = "select pass from board where num=? ";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			if(rs.next()){
				if(rs.getString("pass").equals(pass)){
					sql = "delete from board where num=?";
					pstmt=con.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
				}else{
					check=0;
				}
			}else{
				check=-1;
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
				con.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			
		}
		
		return check;
		
	}
	
	//답글쓰기
	public void insertreBoard(CommentBean cb){
		/*
		 디비연결
		 num게시판 글번호 구하기
		 sql insert
		 실행
		  */
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String sql="";
		int readcount=0;
		int re_seq=0;
		int max=0;
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con = getConnection();
			sql="select max(re_seq) from comment where re_ref=?;";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, cb.getRe_ref());
			rs = pstmt.executeQuery();
			if(rs.next()){
				max=rs.getInt(1);
			}
			
/*			//답글 순서 재배치
			sql="update comment set re_seq=re_seq+1 where re_ref=? and re_seq>?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, cb.getRe_ref());
			pstmt.setInt(2, cb.getRe_seq());
			pstmt.executeUpdate();*/
			
			
			sql = "insert into comment(name, pass,"
					+ " content, re_ref, re_lev, "
							+ "re_seq, date)"
							+ " values(?,?,?,?,?,?,now());";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setString(1, cb.getName());
			pstmt.setString(2, cb.getPass());
			pstmt.setString(3, cb.getContent());
			pstmt.setInt(4, cb.getRe_ref()); // 답변글 그룹
			pstmt.setInt(5, cb.getRe_lev()+1); //답변글 들여쓰기
			pstmt.setInt(6, max+1); //답변글 순서
			
			
			pstmt.executeUpdate();

			


			
			
			
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
	}


}

