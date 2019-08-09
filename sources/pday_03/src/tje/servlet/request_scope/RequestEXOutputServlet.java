package tje.servlet.request_scope;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RequestEXServlet
 */
@WebServlet("/request_ex_output")
public class RequestEXOutputServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out=response.getWriter();
		
		StringBuilder sb=new StringBuilder();
		sb.append("<h2>연산 결과</h2>");
		sb.append(request.getAttribute("output_plus"));
		sb.append(request.getAttribute("output_minus"));
		sb.append(request.getAttribute("output_mul"));
		sb.append(request.getAttribute("output_div"));
		
		out.println(sb);
		
		}

}
