package store;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class GoodsDAO {
	public Connection getConnection() throws Exception {

		// Context객체 생성
		Context init = new InitialContext();
		// DataSource 디비 연동 이름 불러오기
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/mysqlDB");// java:comp/env/까지
																				// 항상
																				// 공통적.
																				// 뒤로는
																				// 이름.
		// con= DataSource형태로 저장
		Connection con = ds.getConnection();
		return con;

	}

	// 상품 찾기
	public List<Object> goodsList(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<Object> list = new ArrayList<Object>();
		GoodsBean gb = null;
		try {

			con = getConnection();

			sql = "select * from goods where id=?;";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			while (rs.next()) {

				gb = new GoodsBean();
				gb.setProduct(rs.getString("product"));
				gb.setPrice(rs.getInt("price"));
				gb.setPic(rs.getString("pic"));
				list.add(gb);

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return list;

	}

	// 스토어 업데이트
	public void updateStore(StoreBean sb) {
		// 2단계 디비연결 => Connection con 객체 저장
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		ResultSet rs = null;
		int check = 1;// 성공
		try {
			con = getConnection();
			sql = "update stores set name=?, address=?, pass=?, email=? where id=?";
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, sb.getName());
			pstmt.setString(2, sb.getAddress());
			pstmt.setString(3, sb.getPass());
			pstmt.setString(4, sb.getEmail());
			pstmt.setString(5, sb.getId());

			pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("DB연결 실패" + e);
		} finally {
			// 객체생성닫기
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

		}

	}

	// 상품 수정
	public void updateGoods(GoodsBean gb, String ori_product) {
		// 2단계 디비연결 => Connection con 객체 저장
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		ResultSet rs = null;
		int check = 1;// 성공
		try {
			con = getConnection();
			sql = "update goods set product=?, price=?, pic=? where product=? and id=?";
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, gb.getProduct());
			pstmt.setInt(2, gb.getPrice());
			pstmt.setString(3, gb.getPic());
			pstmt.setString(4, ori_product);
			pstmt.setString(5, gb.getId());

			pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("DB연결 실패" + e);
		} finally {
			// 객체생성닫기
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

		}

	}

	// 물품 삭제
	public void deleteGoods(String storeId, String product) {
		// 2단계 디비연결 => Connection con 객체 저장
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		ResultSet rs = null;

		try {
			con = getConnection();

			sql = "delete from goods where id=? and product=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, storeId);
			pstmt.setString(2, product);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("DB연결 실패" + e);
		} finally {
			// 객체생성닫기
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

		}

	}

	// 상품 등록
	public void insertGoods(String id, GoodsBean gb) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";

		try {
			con = getConnection();

			sql = "insert into goods(product, price, id, pic) values(?,?,?,?);";
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, gb.getProduct());
			pstmt.setInt(2, gb.getPrice());
			pstmt.setString(3, id);
			pstmt.setString(4, gb.getPic());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	
	// 상품 찜하기
		public void updateGoodsHot(String storeId, String product, String sessionId) {
			// 2단계 디비연결 => Connection con 객체 저장
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = "";
			ResultSet rs = null;
			
			
			try {
				con = getConnection();
				//hot 개수 올리기
				sql = "update goods set hot=hot+1 where product=? and id=?";
				pstmt = con.prepareStatement(sql);

				pstmt.setString(1, product);
				pstmt.setString(2, storeId);

				pstmt.executeUpdate();
				
				//특정 물건 찾기
				GoodsBean gb = searchGoods(storeId, product);
				
				//물건 mygoods로 add
				sql = "insert into mygoods(id, product, price, goods_id, pic) values(?,?,?,?,?);";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, sessionId);
				pstmt.setString(2, gb.getProduct());
				pstmt.setInt(3, gb.getPrice());
				pstmt.setString(4, gb.getId());
				pstmt.setString(5, gb.getPic());
				
				pstmt.executeUpdate();

			} catch (Exception e) {
				System.out.println("DB연결 실패" + e);
			} finally {
				// 객체생성닫기
				if (rs != null) {
					try {
						rs.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				if (con != null) {
					try {
						con.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}

			}

		}
		
		//특정 물건 찾기
		public GoodsBean searchGoods(String storeId, String product) {
			// 2단계 디비연결 => Connection con 객체 저장
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = "";
			ResultSet rs = null;
			GoodsBean gb=null;
			try {
				con = getConnection();
				//hot 개수 올리기
			
				//특정 물건 찾기
				sql = "select * from goods where product=? and id=?";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, product);
				pstmt.setString(2, storeId);
				
				rs = pstmt.executeQuery();
				if(rs.next()){
					gb = new GoodsBean();
					gb.setId(rs.getString("id"));
					gb.setPic(rs.getString("pic"));
					gb.setPrice(rs.getInt("price"));
					gb.setProduct(rs.getString("product"));
				}

			} catch (Exception e) {
				System.out.println("DB연결 실패" + e);
			} finally {
				// 객체생성닫기
				if (rs != null) {
					try {
						rs.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				if (con != null) {
					try {
						con.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}

			}
			
			return gb;

		}
		//인기상품 리스트
		public List<Object> hotgoodsList() {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
			List<Object> list = new ArrayList<Object>();
			GoodsBean gb = null;

			try {

				con = getConnection();

				sql = "select * from goods order by hot desc limit 10;";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					
					gb = new GoodsBean();
					gb.setProduct(rs.getString("product"));
					gb.setPrice(rs.getInt("price"));
					gb.setPic(rs.getString("pic"));
					gb.setId(rs.getString("id"));
					list.add(gb);
					

				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				if (rs != null) {
					try {
						rs.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
			return list;

		}
		//찜목록 리스트
		public List<Object> mygoodsList(String id) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
			List<Object> list = new ArrayList<Object>();
			MygoodsBean mgb = null;
			
			try {
				
				con = getConnection();
				
				sql = "select * from mygoods where id=?;";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					
					mgb = new MygoodsBean();
					mgb.setProduct(rs.getString("product"));
					mgb.setPrice(rs.getInt("price"));
					mgb.setPic(rs.getString("pic"));
					mgb.setId(rs.getString("id"));
					mgb.setGoods_id(rs.getString("goods_id"));
					list.add(mgb);
					
					
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				if (rs != null) {
					try {
						rs.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
			return list;
			
		}
		
		//찜목록 해제
		public void deletemyGoods(String id, String product, String goods_id) {
			// 2단계 디비연결 => Connection con 객체 저장
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = "";
			ResultSet rs = null;
			try {
				con = getConnection();
				sql = "delete from mygoods where id=? and product=? and goods_id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, product);
				pstmt.setString(3, goods_id);
				pstmt.executeUpdate();
			} catch (Exception e) {
				System.out.println("DB연결 실패" + e);
			} finally {
				// 객체생성닫기
				if (rs != null) {
					try {
						rs.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				if (con != null) {
					try {
						con.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}

			}

		}

}
