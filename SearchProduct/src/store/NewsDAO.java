package store;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class NewsDAO {

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
				sql="select count(num) from news";
				
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
		public void insertBoard(NewsBean nb){
			Connection con = null;
			PreparedStatement pstmt=null;
			ResultSet rs = null;
			String sql="";
			int num=0;
			int readcount=0;
			
			try{
				con = getConnection();
				sql="select max(num) from news;";
				pstmt=con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()){
					num=rs.getInt(1)+1;
				}
				
				sql = "insert into news(num, name, subject,"
						+ " content, readcount,date, file)"
								+ " values(?,?,?,?,?,now(),?);";
				pstmt=con.prepareStatement(sql);
				
				pstmt.setInt(1, num);
				pstmt.setString(2, nb.getName());
				pstmt.setString(3, nb.getSubject());
				pstmt.setString(4, nb.getContent());
				pstmt.setInt(5, readcount);
				pstmt.setString(6, nb.getFile());
				
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
			NewsBean nb = null;
			try{
				con=getConnection();
				sql = "select * from news order by num desc limit ?,?;";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, pageSize);
				rs = pstmt.executeQuery();
				while(rs.next()){
					nb = new NewsBean();
					nb.setNum(rs.getInt("num"));
					nb.setName(rs.getString("name"));
					nb.setSubject(rs.getString("subject"));
					nb.setReadcount(rs.getInt("readcount"));
					nb.setDate(rs.getDate("date"));
					nb.setReadcount(rs.getInt("readcount"));
					
					list.add(nb);
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
		
		//search 글 개수
		public int getListCount(String search){
			Connection con = null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			String sql="";
			int num=0;
			
			try{
				con=getConnection();
				sql="select count(num) from news where subject like ?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");
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
		//search 글목록
		public List<Object> boardList(int start, int pageSize, String search){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
			List<Object> list = new ArrayList<Object>();
			NewsBean nb = null;
			try{
				con=getConnection();
				
				sql = "select * from news where subject like ? order by num desc limit ?,? ;";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, pageSize);
				
				rs = pstmt.executeQuery();
				while(rs.next()){
					nb = new NewsBean();
					nb.setNum(rs.getInt("num"));
					nb.setName(rs.getString("name"));
					nb.setSubject(rs.getString("subject"));
					nb.setReadcount(rs.getInt("readcount"));
					nb.setDate(rs.getDate("date"));
					nb.setReadcount(rs.getInt("readcount"));
					
					list.add(nb);
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
		public NewsBean getDetail(int num){
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs = null;
			String sql = "";
			NewsBean nb = null;
			try{
				con=getConnection();
				
				sql = "select * from news where num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs=pstmt.executeQuery();
				if(rs.next()){
					nb = new NewsBean();
					nb.setNum(rs.getInt("num"));
					nb.setName(rs.getString("name"));
					nb.setSubject(rs.getString("subject"));
					nb.setContent(rs.getString("content"));
					nb.setFile(rs.getString("file"));
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
			
			return nb;
		}
		
		
		//조회수 증가
		public void updateReadcount(int num){
			Connection con=null;
			PreparedStatement pstmt=null;
			String sql = "";
			
			try{
				con = getConnection();
				sql = "update news set readcount=readcount+1 where num=? ";
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
		
		
		//글 삭제
		public void deleteBoard(int num){
			Connection con=null;
			PreparedStatement pstmt=null;
			String sql = "";
			ResultSet rs = null;
			int check = 1;
			try{
				con = getConnection();
				sql = "delete from news where num=?";
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
		
		//글 수정
		public void updateBoard(NewsBean nb){
			Connection con=null;
			PreparedStatement pstmt=null;
			String sql = "";
			
			
			
			try{
				con = getConnection();
				sql = "update news set subject=?, content=? where num=? ";
				
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, nb.getSubject());
				pstmt.setString(2, nb.getContent());;
				pstmt.setInt(3, nb.getNum());
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
		
		
		

}