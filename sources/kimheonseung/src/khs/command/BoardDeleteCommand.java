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

public class BoardDeleteCommand extends Command {
	private String formPage = "/WEB-INF/forms/board_delete.jsp";
	private String submitPage = "/WEB-INF/submits/board_delelte.jsp";
	private String errorPage = "/WEB-INF/errors/board_delete.jsp";

	private Board_InfoService biService = new Board_InfoService();
	private Board_InfoDeleteService bidService = new Board_InfoDeleteService();

	protected String processForm(HttpServletRequest request, HttpServletResponse response) {
		
		try (Connection conn = ConnectionProvider.getConnection()) {
			
			HashMap<String, Object> values = new HashMap<>();
			values.put("conn", conn);
			
			HashMap<String, Object> resultMap = biService.service(values);
			ArrayList<Board_Info> boardList = (ArrayList<Board_Info>) resultMap.get("boardList");
			
			request.setAttribute("boardList", boardList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
		return formPage;
	}

	protected String processSubmit(HttpServletRequest request, HttpServletResponse response) {
		
		String board_name = request.getParameter("board_name");
		
		Board_Info model = new Board_Info();
		model.setBoard_name(board_name);
		
		boolean result = false;
		
		try (Connection conn = ConnectionProvider.getConnection()) {
			
			HashMap<String, Object> values = new HashMap<>();
			values.put("conn", conn);
			values.put("model", model);
			
			HashMap<String, Object> resultMap = bidService.service(values);
			result = (Boolean) resultMap.get("result");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if(result == true) {
			return submitPage;
		} else {
			return errorPage;
		}
		
	}
}
