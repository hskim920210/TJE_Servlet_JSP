package khs.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import khs.jdbc.util.*;
import khs.model.*;
import khs.service.*;

public class CommentWriteCommand extends Command {
	private String formPage = null;
	private String submitPage = "/detail_board.do?article_num=";
	private String errorPage = "/WEB-INF/errors/write_comment.jsp";

	private CommentInsertService ciService = new CommentInsertService();

	protected String processForm(HttpServletRequest request, HttpServletResponse response) {
		return formPage;
	}

	protected String processSubmit(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("login_user");
		
		String strArticle_num = request.getParameter("article_num");
		int article_num = 0;
		try {
			article_num = Integer.parseInt(strArticle_num);
		}catch (Exception e) {
			request.setAttribute("errorMsg", "잘못된 접근입니다.");
			return errorPage;
		}		
		String content = request.getParameter("content");
		
		Comments model = new Comments(0, article_num, user.getUser_id(), user.getUser_nick(), content, null);
		
		boolean result = false;
		int last_id = 0;
		
		try (Connection conn = ConnectionProvider.getConnection()) {
			
			HashMap<String, Object> values = new HashMap<>();
			values.put("conn", conn);
			values.put("model", model);
			
			HashMap<String, Object> resultMap = ciService.service(values);
			result = (Boolean) resultMap.get("result");
			last_id = (Integer)resultMap.get("id");
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		model.setWrite_time(new Timestamp(System.currentTimeMillis()));
		String output = 
			String.format("{ \"result\" : \"%b\", \"article_num\" : \"%d\", \"user_id\" : \"%s\", \"comment_id\" : \"%d\", \"content\" : \"%s\", \"date\" : \"%s\" }", 
					result, article_num, user.getUser_id(), last_id, content, model.getWrite_timeString());
		out.println(output);
		out.flush();
		out.close();
		if(result) {
		} else {
			
		}

		return null;
	}
}
