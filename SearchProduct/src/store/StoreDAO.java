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
	public Connection getConnection() throws Exception {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/mysqlDB");
		Connection con = ds.getConnection();
		return con;
	}

	// 스토어 등록
	public void insertStore(StoreBean sb) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";

		try {
			con = getConnection();
			sql = "insert into stores(name, address, id, pass, email, reg_date, type) values(?,?,?,?,?,?,?);";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, sb.getName());
			pstmt.setString(2, sb.getAddress());
			pstmt.setString(3, sb.getId());
			pstmt.setString(4, sb.getPass());
			pstmt.setString(5, sb.getEmail());
			pstmt.setTimestamp(6, sb.getReg_date());
			pstmt.setString(7, sb.getType());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (con != null) {
				try {
					con.close();
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
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

	}

	// 아이디 중복 확인
	public boolean storeIdDupCheck(String id) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		boolean check = false;// 아이디 중복
		try {
			con = getConnection();
			sql = "select * from stores where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return check;// 아이디 중복
			} else if (rs.next() == false) {
				check = true;// 아이디 중복 안됨
				return check;
			}
		} catch (Exception e) {
			System.out.println("DB연결 실패" + e);

		} finally {
			if (con != null) {
				try {
					con.close();
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
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return check;

	}

	// 스토어 로그인
	public int isStoreAdmin(String id, String pass) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int check = 1;// 성공

		try {
			con = getConnection();
			sql = "select pass from stores where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (pass.equals(rs.getString(1))) {
				} else {
					check = -1;// 비밀번호 없음
				}
			} else {
				check = 0;// 아이디 없음
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (con != null) {
				try {
					con.close();
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
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return check;
	}

	// typeCheck
	public String typeCheck(String id) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		String type = "";

		try {
			con = getConnection();
			sql = "select type from stores where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				type = rs.getString(1);
			} else {
				type = "";// 아이디 없음
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (con != null) {
				try {
					con.close();
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
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return type;

	}

	// 로그인 정보
	public StoreBean infoStore(String id) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		StoreBean sb = null;
		ResultSet rs = null;

		try {
			sb = new StoreBean();
			con = getConnection();
			sql = "select * from stores where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				sb.setName(rs.getString("name"));
				sb.setAddress(rs.getString("address"));
				sb.setId(rs.getString("id"));
				sb.setPass(rs.getString("pass"));
				sb.setEmail(rs.getString("email"));
				sb.setReg_date(rs.getTimestamp("reg_date"));

			}

			return sb;

		} catch (Exception e) {
			System.out.println("DB연결 실패" + e);
		} finally {
			if (con != null) {
				try {
					con.close();
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
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

		return null;
	}

	// 스토어 업데이트
	public void updateStore(StoreBean sb) {
		// 2단계 디비연결 => Connection con 객체 저장
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
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
			if (con != null) {
				try {
					con.close();
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
		}
	}

	// 스토어 삭제
	public void deleteStore(String id) {
		// 2단계 디비연결 => Connection con 객체 저장
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		try {
			con = getConnection();
			sql = "delete from stores where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			
			sql = "delete from mygoods where goods_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("DB연결 실패" + e);
		} finally {
			if (con != null) {
				try {
					con.close();
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
		}
	}
	
	// 상품 찾기
	public List<Object> storeList(String product, int start, int pageSize) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<Object> list = new ArrayList<Object>();
		GoodsBean gb = null;

		try {
			con = getConnection();
			sql = "select * from goods where product like ? limit ?,?;";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + product + "%");
			pstmt.setInt(2, start);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				gb = new GoodsBean();
				gb.setId(rs.getString("id"));
				gb.setPic(rs.getString("pic"));
				gb.setProduct(rs.getString("product"));
				gb.setPrice(rs.getInt("price"));
				gb.setHot(rs.getInt("hot"));
				list.add(gb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (con != null) {
				try {
					con.close();
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

	// 검색된 수
	public int getSearchListCount(String product) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int num = 0;

		try {
			con = getConnection();
			sql = "select count(product) from goods where product like ?;";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + product + "%");
			rs = pstmt.executeQuery();
			if (rs.next()) {
				num = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (con != null) {
				try {
					con.close();
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
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

		return num;
	}

	// 검색된 수
	public int getStoreSearchCount(String store) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int num = 0;
		try {
			con = getConnection();
			sql = "select count(id) from stores where name like ?;";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + store + "%");
			rs = pstmt.executeQuery();
			if (rs.next()) {
				num = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (con != null) {
				try {
					con.close();
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
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return num;
	}

	// 스토어 찾기(이름으로)
	public List<Object> storeSearchList(String store, int start, int pageSize) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<Object> list = new ArrayList<Object>();
		StoreBean sb = null;

		try {
			con = getConnection();
			sql = "select * from stores where name like ? limit ?,?;";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + store + "%");
			pstmt.setInt(2, start);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				sb = new StoreBean();
				sb.setId(rs.getString("id"));
				sb.setAddress(rs.getString("address"));
				sb.setName(rs.getString("name"));
				sb.setPass("pass");
				list.add(sb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (con != null) {
				try {
					con.close();
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

	// 스토어 찾기(아이디로 으로)
	public StoreBean storeSearch(String storeId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<Object> list = new ArrayList<Object>();
		StoreBean sb = new StoreBean();
		try {
			con = getConnection();
			sql = "select * from stores where id=?;";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, storeId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				sb.setAddress(rs.getString("address"));
				sb.setEmail(rs.getString("email"));
				sb.setId(rs.getString("id"));
				sb.setName(rs.getString("name"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (con != null) {
				try {
					con.close();
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
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return sb;

	}
	
	// 모든 아이디 추출
	public List<String> searchAllId() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<String> idList = new ArrayList<String>();

		try {
			con = getConnection();
			sql = "select id from stores";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				idList.add(rs.getString("id"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (con != null) {
				try {
					con.close();
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
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return idList;
	}
}
