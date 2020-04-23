<%@page contentType="text/html; charset=UTF-8"%>
<!--
	jsp to fetch pages from startPage to endPage (inclusive) for the given dataset
	is used in an ajax call inside jog.js, never rendered directly
 -->

<%@page language="java" import="edu.stanford.muse.webapp.*"%>
<%@page language="java" import="edu.stanford.muse.index.*"%>
<%@ page import="edu.stanford.muse.util.EmailUtils" %>
<%@ page import="edu.stanford.muse.util.Pair" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.stream.Collectors" %>
<%@page contentType="text/html; charset=UTF-8"%>

<%
	String datasetId = request.getParameter("datasetId");
	DataSet dataset = (DataSet) JSPHelper.getSessionAttribute(session, datasetId);
	boolean error = (dataset == null);

	String archiveID = request.getParameter("archiveID");

	int startPage = HTMLUtils.getIntParam(request, "startPage", -1);
	int endPage = HTMLUtils.getIntParam(request, "endPage", -1);
	boolean inFull = HTMLUtils.getIntParam(request, "inFull", 0) != 0;
	boolean debug = HTMLUtils.getIntParam(request,"debug", 0) != 0;
	JSPHelper.log.info("jogpage: " + debug + ", " + request.getParameter("debug"));

	JSPHelper.log.info ("Fetching pages [" + startPage + ".." + endPage + "] for dataset " + datasetId);

// output format needed: an external div, which contains individual page divs
	out.println ("<div>");

	boolean IA_links = "true".equals(JSPHelper.getSessionAttribute(session, "IA_links"));
	//here each page corresponds to a year. Let us say that the range of years for dataset is from 1954 to 1978 then on first page the attachments for
	//year 1954 will be displayed. On the second page the attachments for 1955 will be displayed.
    List<Pair<Integer,Integer>> yearwiseAttachments = EmailUtils.getStartEndYearOfAttachments(dataset.getDocs());
    int startYear = yearwiseAttachments.get(0).first; //Becuase the list is already in sorted order.
	for (int i = startPage+startYear; i <= endPage+startYear; i++) // note: start and end page inclusive
	{
		out.println ("<div class=\"page\" pageId=\"" + i + "\" display=\"none\">");
		if (error)
			out.println ("Sorry, error reading document " + i + ". Session may have timed out. Please log out and try again. (Doc set:" + datasetId + ")");
		else
		{
			try {
				out.println ("<script>$('.qtip').remove()</script>");
				out.println (dataset.getPageForAttachments(i, IA_links, inFull, debug,archiveID));
				out.println ("\n");
                out.println ("<script src=\"js/epadd.js\"></script>");
				out.println ("<script>initialiseqtip()</script>");
			} catch (Exception e) {
				out.println ("Sorry... exception reading page content: " + e);
			}
		}
		out.println ("</div>");
	}
	out.println ("</div>");
%>
