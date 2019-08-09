package khs.service;

import java.sql.*;
import java.util.*;
import khs.dao.*;
import khs.model.*;

public class BoardAndCommentService implements Service {
	private CommentsDAO commentDAO = new CommentsDAO();
	
	public HashMap<String, Object> service(HashMap<String, Object> values) {
		HashMap<String, Object> result = new HashMap<>();
		
		Connection conn = (Connection)values.get("conn");
		ArrayList<SimpleBoard> simpleBoard = (ArrayList<SimpleBoard>)values.get("simpleBoard");
		
		HashMap<Integer, Object> articleNumAndCommentMap = new HashMap<Integer, Object>();
		HashMap<Integer, Object> articleNumAndCommentUserMap = new HashMap<Integer, Object>();
		if(values.get("type").equals("my")) {
			ArrayList<SimpleBoardWithUser> simpleBoardWithUser = (ArrayList<SimpleBoardWithUser>)values.get("simpleBoardWithUser");
			for(SimpleBoardWithUser sbwu : simpleBoardWithUser) {
				int article_num = sbwu.getArticle_num();
				Comments comment = new Comments(0, article_num, null, null, null, null);
				
				Integer comment_count = commentDAO.selectCount(conn, comment);
				articleNumAndCommentUserMap.put(article_num, comment_count);
				
			}
			result.put("articleNumAndCommentUserMap", articleNumAndCommentUserMap);
			return result;
		} else if (values.get("type").equals("articleComment")){
			for(SimpleBoard sb : simpleBoard) {
				int article_num = sb.getArticle_num();
				Comments comment = new Comments(0, article_num, null, null, null, null);
				
				Integer comment_count = commentDAO.selectCount(conn, comment);
				articleNumAndCommentMap.put(article_num, comment_count);
			}
			
			result.put("articleNumAndCommentMap", articleNumAndCommentMap);
			return result;
		}
		
		return null;
	}
}







