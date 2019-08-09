package khs.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.*;
import java.sql.*;
import khs.jdbc.util.*;
import khs.model.*;
import khs.service.*;

public class MyArticlesCommand extends Command {
	private String formPage = "/WEB-INF/forms/my_articles.jsp";
	private String submitPage = "/WEB-INF/submits/my_articles.jsp";
	private String errorPage = "/WEB-INF/errors/my_articles.jsp";

	private LimitService lService = new LimitService();
	private CommentListService clService = new CommentListService();
	private CommentMyListService cmlService = new CommentMyListService();
	private BoardAndCommentService bacService = new BoardAndCommentService();
	
	protected String processForm(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("login_user");
		
		try (Connection conn = ConnectionProvider.getConnection()) {

			HashMap<String, Object> values = new HashMap<>();
			values.put("conn", conn);
			values.put("user", user);
			
			HashMap<String, Object> resultMap = lService.service(values);
			
			ArrayList<SimpleBoardWithUser> articleList = (ArrayList<SimpleBoardWithUser>)resultMap.get("articleList");
			
			request.setAttribute("articleList", articleList);
			
			
			resultMap = cmlService.service(values);
			ArrayList<Comments> commentMyList = (ArrayList<Comments>)resultMap.get("commentMyList");
			request.setAttribute("commentMyList", commentMyList);
			
			
			values.put("type", "my");
			values.put("simpleBoardWithUser", articleList);
			
			HashMap<String, Object> articleNumAndCommentUserResultMap = bacService.service(values);
			request.setAttribute("articleNumAndCommentUserMap", articleNumAndCommentUserResultMap.get("articleNumAndCommentUserMap"));
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return formPage;
	}

	// POST 요청일 경우의 처리 로직을 구현하는 메소드
	protected String processSubmit(HttpServletRequest request, HttpServletResponse response) {
		return null;
	}

}
