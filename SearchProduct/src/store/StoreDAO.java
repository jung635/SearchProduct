package store;

import java.sql.Connection;
import java.sql.DriverManager;
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
	//////////////////////////////////////////////스토어 계정
	//스토어 등록
	public void insertStore(StoreBean sb){

		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String sql="";
		//int num=0;
		//int readcount=0;
		
		try{
			con = getConnection();
/*			sql="select count(num) from stores";
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				num=rs.getInt(1);
			}*/
			
			sql = "insert into stores(name, address, id, pass, email, reg_date, type) values(?,?,?,?,?,?,?);";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setString(1, sb.getName());
			pstmt.setString(2, sb.getAddress());
			pstmt.setString(3, sb.getId());
			pstmt.setString(4, sb.getPass());
			pstmt.setString(5, sb.getEmail());
			pstmt.setTimestamp(6, sb.getReg_date());
			pstmt.setString(7, sb.getType());
			
			
			
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
	
	//아이디 중복 확인
	public boolean storeIdDupCheck(String id){
		
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		boolean check=false;//아이디 중복
		try{
			con = getConnection();
			sql= "select * from stores where id=?";
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
		return check;
		
		
	}	
	
	
	
	//스토어 로그인
	public int isStoreAdmin(String id, String pass){
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String sql="";
		int check=1;//성공
		
		try{
			con = getConnection();

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
	
	//typeCheck
		public String typeCheck(String id){
			
			Connection con = null;
			PreparedStatement pstmt=null;
			ResultSet rs = null;
			String sql="";
			String type="";
			
			try{
				con = getConnection();

				
				sql = "select type from stores where id=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, id);
				rs=pstmt.executeQuery();
				if(rs.next()){
					type=rs.getString(1);
				}else{
					type="";//아이디 없음
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
			return type;
			
		}	
	
	//로그인 정보
		public StoreBean infoStore(String id){


			Connection con = null;
			PreparedStatement pstmt=null;
			String sql="";
			StoreBean sb = null;
			ResultSet rs = null;
			
			try{
				sb = new StoreBean();
				con=getConnection();
				sql = "select * from stores where id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				while(rs.next()){
					sb.setName(rs.getString("name"));
					sb.setAddress(rs.getString("address"));
					sb.setId(rs.getString("id"));
					sb.setPass(rs.getString("pass"));
					sb.setEmail(rs.getString("email"));
					sb.setReg_date(rs.getTimestamp("reg_date"));
					
				}
				
				return sb;
				
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
		
		//스토어 업데이트
		public void updateStore(StoreBean sb){
			//2단계 디비연결 => Connection con 객체 저장
			Connection con = null;
			PreparedStatement pstmt=null;
			String sql="";
			ResultSet rs = null;
			int check = 1;//성공
			try{
				con=getConnection();
				sql = "update stores set name=?, address=?, pass=?, email=? where id=?";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, sb.getName());
				pstmt.setString(2, sb.getAddress());
				pstmt.setString(3, sb.getPass());
				pstmt.setString(4, sb.getEmail());
				pstmt.setString(5, sb.getId());
				
				pstmt.executeUpdate();
				
				
				
				
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
			
		}
		
		//스토어 삭제
		public void deleteStore(String id){
			//2단계 디비연결 => Connection con 객체 저장
			Connection con = null;
			PreparedStatement pstmt=null;
			String sql="";
			ResultSet rs = null;
			int check = 1;//성공
			try{
				con=getConnection();
				sql = "delete from stores where id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.executeUpdate();
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
					
				}
		
		//스토어 아이디 찾기
		
	/*	public String searchStoreId(String , String address){
			
			Connection con = null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			String sql="";
			String id="";//아이디 중복
			try{
				con = getConnection();
				sql= "select id from stores where ad_id=? and address=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, ad_id);
				pstmt.setString(2, address);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					id=rs.getString(1);
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
			return id;
			
			
		}	*/
	
		//////////////////////////////////////////////스토어 상품 관련
		

	
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
		public List<Object> storeList(String product){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
			List<Object> list = new ArrayList<Object>();
			GoodsBean gb = null;
			
			try{
				con=getConnection();
				
				sql = "select * from goods where product like ?;";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + product + "%");
				rs = pstmt.executeQuery();

				while(rs.next()){

					gb=new GoodsBean();
					gb.setId(rs.getString("id"));
					gb.setPic(rs.getString("pic"));
					gb.setProduct(rs.getString("product"));
					gb.setPrice(rs.getInt("price"));
					gb.setHot(rs.getInt("hot"));
					list.add(gb);

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
/*		//상품 찾기
		public List<Object> storeList(String product){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
			List<Object> list = new ArrayList<Object>();
			StoreBean sb = null;
			GoodsBean gb = null;
			
			try{
				con=getConnection();
				
				sql = "select id from goods where product like ?;";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + product + "%");
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					sql = "select * from stores where id=?;";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, rs.getString("id"));
					ResultSet rs2 = pstmt.executeQuery();
					
					while(rs2.next()){
						sb=new StoreBean();
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
*/		
		//스토어 찾기(이름으로)
				public List<Object> storeSearchList(String store){
					Connection con = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					String sql = "";
					List<Object> list = new ArrayList<Object>();
					StoreBean sb = null;
					
					try{
						
						con=getConnection();
						
						sql = "select * from stores where name like ?;";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, "%"+store+"%");
						rs = pstmt.executeQuery();

						
						while(rs.next()){
							
							sb=new StoreBean();
							sb.setId(rs.getString("id"));
							sb.setAddress(rs.getString("address"));
							sb.setName(rs.getString("name"));
							sb.setPass("pass");
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
				//스토어 찾기(아이디로 으로)
				public StoreBean storeSearch(String storeId){
					Connection con = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					String sql = "";
					List<Object> list = new ArrayList<Object>();
					String address="";
					StoreBean sb = new StoreBean();
					try{
						
						con=getConnection();
						
						sql = "select * from stores where id=?;";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, storeId);
						rs = pstmt.executeQuery();
						
						
						while(rs.next()){
		
							sb.setAddress(rs.getString("address"));
							sb.setEmail(rs.getString("email"));
							sb.setId(rs.getString("id"));
							sb.setName(rs.getString("name"));

								
							
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
					
					return sb;
					
					
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
