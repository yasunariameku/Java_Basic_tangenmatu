<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%
// セッションからプレイヤー名を取得する
	//char winner = (char) session.getAttribute("player");

	String playerCountFin = (String) session.getAttribute("playerCountStr");
	//out.println(playerCountFin);
	int playerCountInt = Integer.parseInt(playerCountFin);
	
	char winLoseAlf = 'a';
	String winLose = "";

	if (playerCountInt > 2) {
		winLoseAlf = (char) session.getAttribute("player");
		winLose = "敗者：";
	
	}else {
		winLoseAlf = (char) session.getAttribute("player");
		winLose = "勝者：";
		
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Java基礎課題</title>
<link href="css/styles.css" rel="stylesheet">
</head>
<body>
  <h1>石取りゲーム</h1>
  <div class="info">
    <h2>
      <%= winLose %>プレイヤー<%= winLoseAlf %> ！！
    </h2>
    <form action="index.jsp">
      <button class="btn" type="submit">先頭に戻る</button>
    </form>
  </div>
</body>
</html>