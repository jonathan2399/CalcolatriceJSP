<html>	
	<head>
		<title>Calcolatrice</title>
	</head>
	<body bgcolor="#FFFF99">
		<h1><font face="calibri" size="9">Calcolatrice JSP</font></h1>
		<%!
			public boolean is2Integer(String string_op1,String string_op2){
				try{
					Double op1 = Double.parseDouble(string_op1);
					Double op2 = Double.parseDouble(string_op2);
				}
				catch(Exception e){
					return false;
				}
				return true;
			}
		%>
		
		<%!
			public boolean is1Integer(String string_op1){
				try{
					Double op1 = Double.parseDouble(string_op1);
				}
				catch(Exception e){
					return false;
				}
				return true;
			}
		%>
		
		<%
			double risultato = 0;
			String operaz = "0";
			String operatore = request.getParameter("operatore");
			String string_op1 = request.getParameter("op1");
			String string_op2 = request.getParameter("op2");
			double op1 = 0;
			double op2 = 0;
			boolean op_invalido = false;
			boolean strint = false;
			
			//a)controllo presenza operatore
			if(operatore==null){
				out.println("<p><font face=\"calibri\" size=\"5\">Benvenuto nella calcolatrice JSP.<br>Di seguito sono elencate le operazioni disponibili.<br>");
				out.println("<br>Con un operando:<br>- operatore=rad - Radice quadrata<br>- operatore=log - Logaritmo naturale<br>");
				out.println("<a href=\"http://localhost:8080/JSPcalculator/?operatore=log&op1=3\">Clicca qui un esempio di operazione a 1 operando</a><br>");
				out.println("<br>Con due operandi:<br>- operatore=add - Addizione<br>- operatore=sot - Sottrazione<br>- operatore=div - Divisione<br>- operatore=mol - Moltiplcazione<br>");
				out.println("<a href=\"http://localhost:8080/JSPcalculator/?operatore=add&op1=22&op2=34\">Clicca qui per un esempio di operazione a 2 operandi</a><br></font>");
			}
			
			//b)controllo presenza di un operando in caso di rad e log
			else if((operatore.equals("rad")||operatore.equals("log"))&&string_op1==null){
				out.println("<p><font face=\"calibri\" size=\"5\">Errore: devi valorizzare l'operando 1.<br>");
				out.println("<a href=\"http://localhost:8080/JSPcalculator/?operatore=log&op1=3\">Clicca qui per un esempio di operazione a 1 operando</a><br></font>");
			}
			
			//c)controllo presenza di 2 operandi in caso di add, sot, div e mol
			else if((operatore.equals("add")||operatore.equals("sot")||operatore.equals("mol")||operatore.equals("div"))&&(string_op1==null||string_op2==null)){
				out.println("<p><font face=\"calibri\" size=\"5\">Errore: devi valorizzare entrambi gli operandi.<br>");
				out.println("<a href=\"http://localhost:8080/JSPcalculator/?operatore=add&op1=22&op2=34\">Clicca qui per un esempio di operazione a 2 operandi</a></font>");
			}
			
			//d)se i parametri sono espressi correttamente
			else
			{
				if(operatore.equals("add")||operatore.equals("sot")||operatore.equals("mol")||operatore.equals("div")){
					strint = is2Integer(string_op1,string_op2);
					if(strint==true){
						op1 = Double.parseDouble(string_op1);
						op2 = Double.parseDouble(string_op2);
						if(operatore.equals("add")){
						risultato = op1+op2;
						operaz = "+";
						}
						else if(operatore.equals("sot")){
							risultato = op1-op2;
							operaz = "-";
						}
						else if(operatore.equals("div")){
							if(op2!=0){
								risultato = op1/op2;
								operaz = "/";							
							}
							else
								op_invalido = true;
						}
						else if(operatore.equals("mol")){
							risultato = op1*op2;
							operaz = "*";
						}
						
						if(op_invalido == false)
							out.println("<p><font face=\"calibri\" size=\"5\">OPERAZIONE: "+op1+" "+operaz+" "+op2+"= "+risultato+"</font></p>");
						else
							out.println("<p><font face=\"calibri\" size=\"5\">Divisione per zero!</font></p>");
					}
					else{
						out.println("<p><font face=\"calibri\" size=\"5\">Parametri errati!</font></p>");
					}
				}
				
				else if(operatore.equals("rad")||operatore.equals("log")){
					strint = is1Integer(string_op1);
					if(strint==true){
						op1 = Double.parseDouble(string_op1);
						if(operatore.equals("log")){
							if(op1>0){
								risultato = Math.log(op1);
								operaz = "LOGN";
							}
							else
								op_invalido = true;
						}
						else if(operatore.equals("rad")){
							if(op1>=0){
								risultato = Math.sqrt(op1);
								operaz = "RADQ";
							}
							else
								op_invalido = true;
						}
						if(op_invalido == false)
							out.println("<p><font face=\"calibri\" size=\"5\">OPERAZIONE: "+operaz+" "+op1+"= "+risultato+"</font></p>");
						else{
							out.println("<p><font face=\"calibri\" size=\"5\">Impossibile completare l'operazione con il parametro passato.<br>");
							out.println("Si ricorda che:<br>");
							out.println("- In caso di radice si richiede un operando >= 0<br>");
							out.println("- In caso di logaritmo si richiede un operando > 0<br>");
						}
					}
					else{
						out.println("<p><font face=\"calibri\" size=\"5\">Parametro errato!</font></p>");
					}
				}
				else{
					out.println("<p><font face=\"calibri\" size=\"5\">Non hai espresso correttamente la richiesta, passando un operatore errato.<br>Quelli disponibili sono elencati di seguito.<br>");
					out.println("<br>Con un operando:<br>- operatore=rad - Radice quadrata<br>- operatore=log - Logaritmo naturale<br>");
					out.println("<a href=\"http://localhost:8080/JSPcalculator/?operatore=log&op1=3\">Clicca qui un esempio di operazione a 1 operando</a><br>");
					out.println("<br>Con due operandi:<br>- operatore=add - Addizione<br>- operatore=sot - Sottrazione<br>- operatore=div - Divisione<br>- operatore=mol - Moltiplcazione<br>");
					out.println("<a href=\"http://localhost:8080/JSPcalculator/?operatore=add&op1=22&op2=34\">Clicca qui per un esempio di operazione a 2 operandi</a><br></font>");
				}
			}
		%>
		<script>
			function numinput(){
				if(document.getElementById("operatore").value=="rad"||document.getElementById("operatore").value=="log"){
					document.getElementById("operandi").innerHTML="<br><input type=\"text\" name=\"op1\" id=\"op1\"/>";
					document.getElementById("pulsante").innerHTML="<input type=\"button\" onclick=\"window.location.replace('http://localhost:8080/JSPcalculator/?operatore='+operatore.value+'&op1='+op1.value+'')\" value=\"Calcola!\">";
				}
				else{
					document.getElementById("operandi").innerHTML="<br><input type=\"text\" name=\"op1\" id=\"op1\" /><br><input type=\"text\" name=\"op2\" id=\"op2\"/>";
					document.getElementById("pulsante").innerHTML="<br><input type=\"button\" onclick=\"window.location.replace('http://localhost:8080/JSPcalculator/?operatore='+operatore.value+'&op1='+op1.value+'&op2='+op2.value+'')\" value=\"Calcola!\">";
				}
			}
		</script>
		
		<font face="calibri" size="5">
		<br><br>---<br>Scegli che tipo di operazione vuoi eseguire: <select id="operatore" name="operatore" onchange="numinput()">
			<option value=""></option>
			<option value="add">+</option>
			<option value="sot">-</option>
			<option value="div">/</option>
			<option value="mol">*</option>
			<option value="log">log</option>
			<option value="rad">rad</option>
		</select>

		<div id="operandi">
		</div>
		
		<div id="pulsante">
		</div>
	</body>
</html>




