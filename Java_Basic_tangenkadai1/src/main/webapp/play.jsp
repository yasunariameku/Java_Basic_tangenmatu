<%@page import="util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%

	//一度に取る石の数をString型で取得
	String stoneStr = request.getParameter("num");

	// まずplay.jspに画面遷移した後にindex.jspで入力した値を取ってくる

    String stoneTotalStr = request.getParameter("stoneTotal"); //石の総数
    String stoneCountStr = request.getParameter("stoneCount"); //一度に取れる石の数
    String playerCountStr = request.getParameter("playerCount"); //プレイヤーの数
    String stoneSymbolStr = request.getParameter("stoneSymbol"); //石の記号
    

    //1回目限定の処理
    
    /* 入力された石の総数（stoneTotalStr）をゲームの中の石の総数（totalNum）に反映させて、
    セッションに情報を保持させる */
    int stoneTotal = 0;
    
  
    if (session.getAttribute("totalNum") == null) {
    	stoneTotal = Integer.parseInt(stoneTotalStr);
    	session.setAttribute("totalNum", stoneTotal );
    }
    
    //1度に取れる石の数をsession管理
    
    if (session.getAttribute("stoneCountStr") == null){
    	session.setAttribute("stoneCountStr", stoneCountStr);
    }
    stoneCountStr = (String) session.getAttribute("stoneCountStr");

    
    //プレイヤーの数をsessionに保存
    if (session.getAttribute("playerCountStr") == null){
    	session.setAttribute("playerCountStr", playerCountStr);
    }
    
    playerCountStr = (String) session.getAttribute("playerCountStr");
    
    //石の記号をsession管理
    if (session.getAttribute("stoneSymbolStr") == null){
    	session.setAttribute("stoneSymbolStr", stoneSymbolStr);
    }
    
    stoneSymbolStr = (String) session.getAttribute("stoneSymbolStr");

    
    int stone = 0;
 	// 残数の更新処理(残数の取得、更新、保存など)    
    int totalNum = 25; //残数用の変数。仮で25をセットしている必要に応じて変更
    
  	
    //上でsession保存したtotalNumを取得してくる
    totalNum = (int) session.getAttribute("totalNum");
    
    
    if (Utility.isNullOrEmpty(stoneStr) == false ) {   //もし入力された石の個数が0じゃなかったら、
    	stone = Integer.parseInt(stoneStr);            //↑でtrueと判定された場合、取る石の数を文字列型から数値型に変換
    	totalNum = (totalNum - stone);                 // totalNum から↑で数値型に変えた入力された数値を引く
    	session.setAttribute("totalNum", totalNum);
    	
    } else {
    	stone = 0; 
    }
    
    //表示する石の数を関数に入れてtotalNum分表示させる。
    String htmlStone = Utility.getStoneDisplayHTML(totalNum,stoneSymbolStr);
    
    
    //32行目でsessionに保存したプレイヤーの数を数値型に変換する
    int playerCount = Integer.parseInt(playerCountStr);
    
    //プレイヤーの人数分の箱（添え字）を持つ配列を用意する。
    char[] player = new char[playerCount];
    
    //作った配列にfor文でchar型でA～から始まるプレイヤーの値を入れていく。
    for (char i = 0; i < playerCount; i++ ){
    	player[i] = (char)(65 + i);
    	out.println(player[i]);  //確認用の出力文
    	
    }
    

    //もしプレイヤーの値がnullなら、プレイヤーの値は配列playerの添え字[0]を入力する。
    if ( session.getAttribute("player") == null) {
   	     session.setAttribute("player", player[0] );
    } else if (playerCount > 2){   //プレイヤーの切り替え
    	/* ゲームが始まっているのであれば、決定が押されるとplayerの値はnull以外が入力されるはずなので、
    	for文を回して、プレイヤーの人数分、切り替えられるようにしておく */
    	
    	if (totalNum <= 0) {
       	 response.sendRedirect("finish.jsp");
       	 
        } else{
        	
        	for (int i = 0; i < playerCount; i++) {   
        		if (i == playerCount - 1) {
            		session.setAttribute("player", player[0] );
            	}else if ((char)session.getAttribute("player") == player[i]) {
            		session.setAttribute("player", player[i + 1] );
            		break;
            	}
            	
            }
        }
    	
    //プレイヤーが2人だったときの順番切り替えの処理
    }else if (playerCount == 2 ){
    	
    	for (int i = 0; i < playerCount; i++) {   
    		if (i == playerCount - 1) {
        		session.setAttribute("player", player[0] );
        	}else if ((char)session.getAttribute("player") == player[i]) {
        		session.setAttribute("player", player[i + 1] );
        		break;
        	}
        	
        }
    	
    	if (totalNum <= 0) {
          	 response.sendRedirect("finish.jsp");
          	 
         } 
    }
   
    
    char playerStr = (char) session.getAttribute("player");
    
	// 残数が0以下の場合、結果ページへ遷移
    // (responseオブジェクトのsendRedirectメソッドを使用する)
     
    
    
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
  
  <!--   データ送られてるか確認   -->
  <div>
	  石の総数：<%= stoneTotalStr %> <br>
	  
	  一度に取れる石の数：<%= stoneCountStr %> <br>
	  
	  プレイヤーの数： <%= playerCountStr %> <br>
	  
	  石の記号：<%= stoneSymbolStr %> <br>
	 
  </div>
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
      プレイヤー<%=playerStr %>の番
    </h2>

    <form action="play.jsp">
      <p>
        石を
        <input type="number" name="num" min="1" max=<%="\"" + stoneCountStr + "\"" %> >
        個取る<br> ※1度に<%=stoneCountStr %>個取れます。
      </p>
      <button class="btn" type="submit">決定</button>
    </form>
    
    <a href="index.jsp" >戻る</a>
    
  </div>
</body>
</html>