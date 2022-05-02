<%@page import="util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%
	
    String stoneStr = request.getParameter("num");
   
    
    if (session.getAttribute("totalNum") == null) {
    	session.setAttribute("totalNum", 25);
    }
    
    //boolean resultStone = Utility.isNullOrEmpty(stoneStr);     //入力された石の個数がnullか空文字じゃないかの判定
    
    int stone = 0;
 	// 残数の更新処理(残数の取得、更新、保存など)    
    int totalNum = 25; //残数用の変数。仮で25をセットしている必要に応じて変更
    
    totalNum = (int) session.getAttribute("totalNum");
    
    
    
    
    if (Utility.isNullOrEmpty(stoneStr) == false ) {            //もし入力された石の個数が0じゃなかったら（1 or 2 or 3だったら）
    	stone = Integer.parseInt(stoneStr);    //↑でtrueと判定された場合、文字列型から数値型に変換
    	totalNum = (totalNum - stone);  // totalNum(25個)から↑で数値型に変えた入力された数値を引く
    	session.setAttribute("totalNum", totalNum);
    	
    } else {
    	stone = 0; 
    }
    
    String htmlStone = Utility.getStoneDisplayHTML(totalNum);
    
    
    //プレイヤー用の変数。仮で"A"をセットしている。必要に応じて変更
    if ( session.getAttribute("player") == null) {
   	     session.setAttribute("player", "A");
   } 
	
    
    if (!(stone == 0)){
    	if ("A".equals(session.getAttribute("player"))){
    		//player = "B";   //Aの場合はセッションの値をBに切り替え
    		session.setAttribute("player", "B");
    	}else {
    		//player = "A";  //Bの場合はセッションの値をAに切り替え
    		session.setAttribute("player", "A");
    	}
    }
    
     String player = (String) session.getAttribute("player");
      
    
    
	// 残数が0以下の場合、結果ページへ遷移
    // (responseオブジェクトのsendRedirectメソッドを使用する)
     if (totalNum <= 0) {
    	 session.setAttribute("player", player);    	 
    	 response.sendRedirect("finish.jsp");
    }
    
    
  	//プレイヤーの切り替え
    
    
    //session.setAttribute("totalNum", totalNum); //totalNumにセッションで情報をセットする。 

    
    
    
    // プレイヤーの切替処理(プレイヤーの取得、切替、保存など)
    //String playerA = "A";  // プレイヤー用の変数。仮で"A"をセットしている。必要に応じて変更
    //String playerB = "B";
    
    
    
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
      残り：<%= totalNum %>個
    </h2>
    <p class="stone">
      <%=
      htmlStone
          // todo:このprint分は仮の処理。実装が完了したら削除する。
          // 表示する文字列("●●～")をメソッドを使い取得し、取得した文字列を表示する
      %>
    </p>
  </div>
  <div class="info">
    <h2>
      プレイヤー<%=player %>の番
    </h2>

    <form action="play.jsp">
      <p>
        石を
        <input type="number" name="num" min="1" max="25">
        個取る<br> ※1度に3個取れます。
      </p>
      <button class="btn" type="submit">決定</button>
    </form>
  </div>
</body>
</html>