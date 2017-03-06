package store;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class StoreDAO {
	public Connection getConnection() throws Exception{

		//Context객체 생성
		Context init = new InitialContext();
		//DataSource 디비 연동 이름 불러오기
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/mysqlDB");//java:comp/env/까지 항상 공통적. 뒤로는 이름.
		//con= DataSource형태로 저장
		Connection con=ds.getConnection();
		return con;
		
		
		
	}
	
/*	//글 개수
	public int getStoreCount(){
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		int num=0;
		
		try{
			con=getConnection();
			sql="select count(num) from stores";
			
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
	}*/
	
	//스토어 등록
	public void insertStore(StoreBean sb){

		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String sql="";
		//int num=0;
		//int readcount=0;
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con = getConnection();
/*			sql="select count(num) from stores";
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				num=rs.getInt(1);
			}*/
			
			sql = "insert into stores(name, address, id, pass, ad_id) values(?,?,?,?,?);";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setString(1, sb.getName());
			pstmt.setString(2, sb.getAddress());
			pstmt.setString(3, sb.getId());
			pstmt.setString(4, sb.getPass());
			pstmt.setString(5, sb.getAd_id());
			
			
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
	
	
	//스토어 로그인
	public int isStoreAdmin(String id, String pass){
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String sql="";
		int check=1;//성공
		//int num=0;
		//int readcount=0;
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con = getConnection();
/*			sql="select count(num) from stores";
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				num=rs.getInt(1);
			}*/
			
			sql = "select pass from stores where id=?";
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
	
	
	//상품 등록
		public void insertGoods(String id, GoodsBean gb){

			Connection con = null;
			PreparedStatement pstmt=null;
			ResultSet rs = null;
			String sql="";

			
			try{
				Class.forName("com.mysql.jdbc.Driver");
				con = getConnection();
/*				
				sql = "select ad_id from stores where id=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, id);
				rs=pstmt.executeQuery();
				if(rs.next()){
					gb.setId(rs.getString(1));
				
				}*/
				sql = "insert into goods(product, price, id) values(?,?,?);";
				pstmt=con.prepareStatement(sql);
				
				pstmt.setString(1, gb.getProduct());
				pstmt.setInt(2, gb.getPrice());
				pstmt.setString(3, id);
				
				
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
	
/*		//주소 아이디 찾기
		public String searchAd_id(String id){
			Connection con = null;
			PreparedStatement pstmt=null;
			ResultSet rs = null;
			String sql="";
			String ad_id="";
			
			try{
				Class.forName("com.mysql.jdbc.Driver");
				con = getConnection();

				sql = "select ad_id from stores where id=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, id);
				rs=pstmt.executeQuery();
				if(rs.next()){
					ad_id=rs.getString(1);
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
			
			return ad_id;
		}*/
		
	//상품 찾기
		public List<Object> StoreList(String product){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
			List<Object> list = new ArrayList<Object>();
			StoreBean sb = null;
			GoodsBean gb = null;
			
			try{
				
				Class.forName("com.mysql.jdbc.Driver");
				con=getConnection();
				
				sql = "select id from goods where product=?;";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, product);
				rs = pstmt.executeQuery();

				while(rs.next()){
					sql = "select * from stores where id=?;";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, rs.getString("id"));
					ResultSet rs2 = pstmt.executeQuery();
					
					while(rs2.next()){
					sb=new StoreBean();
					sb.setAd_id(rs2.getString("ad_id"));
					sb.setId(rs2.getString("id"));
					sb.setAddress(rs2.getString("address"));
					sb.setName(rs2.getString("name"));
					sb.setPass("pass");
					list.add(sb);
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
			return list;
			
		}
		
/*	//글목록
	public List<Object> boardList(int start, int pageSize){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<Object> list = new ArrayList<Object>();
		StoreBean sb = null;
		try{
			
			Class.forName("com.mysql.jdbc.Driver");
			con=getConnection();
			
			sql = "select * from stores order by num desc limit ?,?;";
			//sql = "select * from board where num>=? and num<=? group by re_ref order by re_ref desc, re_seq asc;";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			while(rs.next()){
				sb = new StoreBean();
				sb.setIndex(rs.getString("index"));
				sb.setName(rs.getString("name"));
				sb.setAddress(rs.getString("address"));
		
				list.add(sb);
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
*/
}
