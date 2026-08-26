	
 
var teste=1;
  var corErroFundo="#FFC";
  var corErroFonte="red";  
  var corOkFundo="#F0FFF0";
  var corOkFonte="green";

	function goToList(OB,ID)
{
		var bAchou=false;
	if (OB!=null)
	{
	for (var c=0;c<OB.length;c++)
		{
		if (OB.options[c].value==ID)
			{
 
			OB.options[c].selected=true;
			bAchou=true;
			c=OB.length;
			}
		}
		
		if (!bAchou) { OB.options[0].selected=true;	return false;	}else return true;
	}
	}
function getSelectionStart (ctrl) { 
        var CaretPos = 0; 
        if (document.selection) { //IE 
                ctrl.focus(); 
                var Sel = document.selection.createRange (); 
                Sel.moveStart ('character', -ctrl.value.length); 
                CaretPos = Sel.text.length; 
        } 
        else return ctrl.selectionStart; //if (ctrl.selectionstart || ctrl.selectionstart == '0'){ // Firefox 
//                CaretPos = ctrl.selectionstart; 
//        } 
        return (CaretPos); 
}
/*
function getSelectionStart(o) {
    if (o.createTextRange) {
        var r = document.selection.createRange().duplicate()
        r.moveEnd('character', o.value.length)
        if (r.text == '') return o.value.length
        return o.value.lastIndexOf(r.text)
    } else return o.selectionStart;
}
*/
function setCaretTo(obj, pos) {   
    if(obj.createTextRange) {   
        /* Create a TextRange, set the internal pointer to  
           a specified position and show the cursor at this  
           position  
        */  
        var range = obj.createTextRange();   
        range.move("character", pos);   
        range.select();   
    } else if(obj.selectionStart) {   
        /* Gecko is a little bit shorter on that. Simply  
           focus the element and set the selection to a  
           specified position  
        */  
        obj.focus();   
        obj.setSelectionRange(pos, pos);   
    }   
}  
function Trim(str){return str.replace(/^\s+|\s+$/g,"");}


//function SuperPegaCampo(url)
function MontaCEP(opcao,campo,end,comp,bairro,cidade,estado,itemm)
{
	var cep=document.getElementById(campo).value;	
	var a=end;
	var b=comp;
	var cc=bairro;
	var d=cidade;
	var ee=estado;
	var op=opcao;
	var it=itemm;
	
 var Retorno=new Array();
	var mreq;
	// Procura o componente nativo do Mozilla/Safari para rodar o AJAX 
	if(window.XMLHttpRequest){
		// Inicializa o Componente XMLHTTP do Mozilla
		mreq = new XMLHttpRequest();
	// Caso ele n�o  encontre, procura por uma vers�o ActiveX do IE 
	}else if(window.ActiveXObject){ 
		// Inicializa o Componente ActiveX para o AJAX
		mreq = new ActiveXObject("Microsoft.XMLHTTP");
	}else{ 
		// Caso n�o consiga inicializar nenhum dos componentes, exibe um erro
		alert("Seu navegador n�o tem suporte a AJAX.");
	}

	// Carrega a fun��o de execu��o do AJAX
	mreq.onreadystatechange = function() {
		
		var send=a;
		var scomp=b;
		var sbairro=cc;
		var scidade=d;
		var sestado=ee;
		var sopcao=op;
		var sitem=it;
 		if(mreq.readyState == 1){
			// Quando estiver "Carregando a p�gina", exibe a mensagem
 		}else if(mreq.readyState == 4){ 
			// Quando estiver completado o Carregamento
			// Procura pela DIV com o id="minha_div" e insere as informa��es 
			var texto=mreq.responseText;
			
			var vInfo = texto.split(",");
			for (var c=0;c<vInfo.length;c++)
				{
					vInfo[c]=Trim(vInfo[c]);
				}
			
			var end=document.getElementById(send+"MSK");
			if (!end) end=document.getElementById(send);
			var end2=document.getElementById(send);
			
			var comp=document.getElementById(scomp+"MSK");
			if (!comp) comp=document.getElementById(scomp);
			var comp2=document.getElementById(scomp);
			var bairro=document.getElementById(sbairro+"MSK");
			if (!bairro) bairro=document.getElementById(sbairro);
			var bairro2=document.getElementById(sbairro);
						

  			var cidade=document.getElementById(scidade);

			if (cidade!=null)
			{
						
			var estado=document.getElementById(sestado);
 			if (vInfo.length==1)
			{
 				cidade.disabled=false;
				estado.disabled=false;
				end.value="";
 				comp.value="";
				bairro.value="";
				end.disabled=false;
				comp.disabled=false;
				bairro.disabled=false;
				cidade.disabled=false;
				estado.disabled=false;
			} else
			{
			 
 			var estadoanterior=estado.options[estado.selectedIndex].value;
			
			if (estadoanterior!=vInfo[0])
				{
				goToList(estado,vInfo[0]);
 				}
				var x=TrocaTexto(sopcao,'<IDCEP>',vInfo[0]);
				x=TrocaTexto(x,'<IDCEP2>',vInfo[1]);				
   			    eval(x);
				

		//	estado.disabled=true;	 			 
 		//	cidade.disabled=true;
			if (vInfo.length>=3)
				{
				bairro.value=vInfo[2];
				if (bairro2) bairro2.value=vInfo[2];
 			//	bairro.disabled=true;
 		 		end.value=vInfo[3];
				if (end2) end2.value=vInfo[3];
 			//	end.disabled=true;				
				comp.value=vInfo[4];
				if (comp2!=null) comp2.value=vInfo[4];
 				if (comp.value=="")
				{
				comp.disabled=false;
 				}
				else
					{
			//	comp.disabled=true;
				}
				} else {
			//		end.disabled=false;
				//	comp.disabled=false;
				//	bairro.disabled=false;					
					}
			try {
			end.onkeyup();
			bairro.onkeyup();
			comp.onkeyup();
		 } catch(e) {}
			}
			}
		}
	};
	// Envia via m�todo GET as informa��es
	
	mreq.open("POST",'/plugins/BuscaCep.jsp?CEP='+cep,true);
    mreq.setRequestHeader("Content-Type", "multipart/form-data") 	
	mreq.send(null);
}

  function FormatarCampo(event,campo,Remover, strMascara,Tipo,bAuxiliar)
        {
			return FormatarCampo(event,campo,Remover, strMascara,Tipo,bAuxiliar,'')
		}
 function FormatarCampo(event,campo,Remover, strMascara,Tipo,bAuxiliar,TCL)
        {
	if (Remover.length>2)
	{
	Remover=TrocaTexto(Remover,".","\\.");	
	Remover=TrocaTexto(Remover,"?","\?");	
	Remover=TrocaTexto(Remover,"!","\!");		
	Remover=TrocaTexto(Remover,"^","\^");			
	Remover=TrocaTexto(Remover,"*","\*");			
	Remover=TrocaTexto(Remover,"%","\%");						
	Remover=TrocaTexto(Remover,"acentos","�|`|�|\\^|~");
	Remover=TrocaTexto(Remover,"sinais","%|\\\\|/|\\?|!|\\+|-|\\*|=|;|:|,|<|>|{|\\[|\\]|}");
	Remover=TrocaTexto(Remover,"especiais","@|#|&|�|�|�|�|�|�|�|�|�|�|_");
	Remover=TrocaTexto(Remover,"letras","[a-zA-Z]");	
	}
//			 document.getElementById("Observacao").value=Remover
//var ob=document.getElementById("Observacao");
//ob.value="";
var objCampo=null;

if (bAuxiliar)
  	 objCampo=document.getElementById(campo+"MSK");
	 else objCampo=document.getElementById(campo);
 if (Tipo=='D') formataData(objCampo);

	var Texto=objCampo.value;
	var retorno=Texto;
 	var mascara2="";
	var sequencia="";
	var sequencia2="";
	var iseq=1;
	var bIniciou=false;
	var bTemMascara=strMascara.length>0;
	var bTeclasEspeciais=false;
var img="";

var objCampoSM=document.getElementById(campo);
var Texto2=objCampoSM.value;

var msgCampo=document.getElementById("msg"+campo);


var tecla;
if (event!=0)
tecla = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
else {tecla=TCL;}
bTeclasEspeciais= RegExp("45|38|39|37|36|36|40|33|34").test(tecla);
var bTeclasEdicao= RegExp("46|8").test(tecla);
//var bUltimo=!(Tipo=='N' || Tipo=='L');
bUltimo=true;
if (!bTeclasEspeciais)
{
 


var letra=0;
if (!bTeclasEspeciais && !bTeclasEdicao)
letra=String.fromCharCode(tecla);
var Posicao=0;

try {Posicao=getSelectionStart(objCampo);} catch (e){};
if (!bTeclasEspeciais)
if (bIE && Posicao<Texto.length) Posicao--;
var bFinal=(Posicao>=Texto.length);
var bInicio=(Posicao==0);
if (!bTeclasEspeciais) bInicio=false;

var bErro=false;

//if (bTeclasEdicao) Posicao--;

//bTeclasEspeciais=bTeclasEspeciais||bTeclasEdicao;
//ob.value=tecla+" =>"+bTeclasEspeciais+" posicao="+Posicao;

if (bTemMascara)
{
var expressao=new RegExp(strMascara);
var Anterior=Texto;
var Mascaras2=new Array();
var Mascaras=new Array();
var Sequencias=new Array();
var Sequencias2=new Array();
var grupo=0;
{
		
	for (var x=0;x<strMascara.length;x++)  
		{
		var letra=strMascara.charAt(x);	
 
		if (letra=='(')  
			{				

//			ob.value+=m2.test(Texto)+"="+maskara2+"  "+seq+"===>"+seq2+" ==>"+Texto+"\n"+bErro+" TCL"+grupo	;
			
			if (!sequencia=="" && grupo==0)
			{			
			var t=mascara2;
			Mascaras2.push(strMascara.substr(0,x));
			Mascaras.push(t);
			 
			Sequencias.push(sequencia);
			Sequencias2.push(sequencia2);
			}
			grupo++;
			bIniciou=true;
				mascara2+=letra;
			}
			else if (letra==')')  
			{
				grupo--;
 				bIniciou=false;
				mascara2+=letra;
				sequencia+="$"+iseq;
				sequencia2+="$"+iseq;
				
				iseq++;
 				} else
			if (!bIniciou)				
				{
				 
				sequencia+=letra;
				}
				else mascara2+=letra;
			
		}
	//	if (!bTeclasEdicao)
		{
	if (Remover!="") 	  {
		var remover=new RegExp(Remover);
		var T=Texto.length;
		for (x=0;x<T;x++)
		{
		if(remover.test(Texto))
			{
if (!bTeclasEspeciais)
			Posicao--;
		Texto=Texto.replace(remover,"");	
//			document.getElementById(campo+"2").value=Remover+"==>"+Texto+"\n\n";
			
			}
			
		}
	}
	 if (Tipo=='N' || Tipo=='L') {
	 var novo=FormataNome(Texto);
	 Posicao-=(Texto.length-novo.length);
	 Texto=novo;
	 }
}
 
 var bfoi=false;
 var bPosicao=false;
 //		document.getElementById(campo+"2").value=Texto;
while (Mascaras.length>0)
	{
		var maskara2=Mascaras2.pop();
		var maskara=Mascaras.pop();
		var seq=Sequencias.pop();
		var seq2=Sequencias2.pop();
		var m=new RegExp("^"+maskara+"");
		var m2=new RegExp("^"+maskara2+"");
		if (bTeclasEdicao && bFinal)
			{
	//		 seq=seq.substr(0,seq.lastIndexOf("$")+2);
			}
		if (!m2.test(Texto) )
		var x=Texto.replace(m,seq);

	//	document.getElementById(campo+"2").value+=m2.test(Texto)+"x="+x+" m2="+m+" ==> seq"+seq+"\n";
				if (m2.test(x))
				{			
				//	var t=seq;
//					t=TrocaTexto(t,"$","");
//					for (var y=10;y>=0;y--)
//					t=TrocaTexto(t,y,"");
//					if (Posicao!=-1)				
//					Posicao+=t.length+1;		
					Texto2=Texto;					
					Texto=x;
					break;
				}
		}
}		}
	

try {
if (Texto.length==0) img="emp";
else if (!bTemMascara || expressao.test(Texto)) img="ok";
else img="err";
} catch (x) {};

if (img=="ok")
	{
	 	
		var erro="";

		if (Tipo=='V') 	 // Valor
		{	
 		if (isNaN(Texto2) || isNaN(Texto)) erro="valor incorreto!";	
		Texto2=Texto;

		}
	else if (Tipo=='C') 
			{
				erro=ValidaCPF(Texto2,true);

				
			}
else if (Tipo=='N')  // NOme
			{
				erro=ValidaNome(Texto,3,"s{2}|r{2}|a{2}|o{2}|l{2}|n{2}|m{2}",2);
				Texto2=Texto;

			}	
else if (Tipo=='L')  // ignora teste de nr de disti
			{
				erro=ValidaNome(Texto,1,"[0-9]*|s{2}|r{2}|a{2}|o{2}|i{3}|l{2}|n{2}|m{2}|%|\\\\|/|\\?|!|\\+|-|\\*|=|;|:|,|<|>|{|\\[|\\]|}",1);
				Texto2=Texto;
			}			
	else if (Tipo=='J') 			
		{
			erro=valida_cnpj(Texto2);
		}
	else if (Tipo=='P') 			
		{
			erro="";
		}		
		if(erro!="")					
					{
					msgCampo.innerHTML="<br>"+erro;
					img="emp";
					Texto2='';
					}
					else {
						try {
						msgCampo.innerHTML=erro;
						} catch (e) {alert('sem campo de msg para'+objCampo.name);}
						//Texto2=Texto;
						objCampo.style.color=corOkFonte; 
					}
					 			
      								
//	else if (Tipo.charAt(0)=='@') Texto=Texto.replace(/\D/g,"");	

	}else Texto2='';
	
 if (Tipo=='D' && Texto.charAt(Texto.length-1)=='-')
 	{
		Texto=Texto.substr(0,Texto.length-1);
	}
//document.getElementById(campo+"2").value+=Texto2+"\n";	
		//	Texto2+=" TP="+Tipo;
//background:#00CC00 url(i/ok.jpg) no-repeat top right; 	
//objCampo.setAttribute("background",'url(css/original/v_'+img+'.gif)');

//	objCampo.css('background-image',);
//if (bTeclasEspeciais && tecla!=39) Posicao--;
//document.getElementById(campo+"2").value+="tecla="+tecla+" letra="+letra+" ==> "+Posicao;
 	{
	bUltimo=true;	

objCampo.style.backgroundImage='url(https://www.virtualclass.com.br/repositorio/css/original/v_'+img+'.gif)';
objCampo.style.backgroundPosition="right";
objCampo.style.backgroundRepeat="no-repeat";
// objCampo.style.paddingLeft='17px';
        objCampo.value=Texto;
 	   setCaretTo(objCampo,Texto.length);	 // remover um dia
	   if (bAuxiliar)
	   objCampoSM.value=Texto2;
//	   if (bTeclasEdicao)  Posicao--;
	//	if (Posicao!=-1)
			{			

			/*	if (bFinal || bUltimo)
				setCaretTo(objCampo,Texto.length);	   
				else if (bInicio)
				setCaretTo(objCampo,0);	   
				else setCaretTo(objCampo,Posicao);	 */  
			}
	}
}
	try {document.getElementById(campo+"2").value="Texto2="+Texto2+" Texto."+Texto+" ==> "+Posicao;} catch (e) {}
//if (bUltimo) setCaretTo(objCampo,Texto.length);	 



if (img=="ok") return true;
else return false;
        }  

function FormataNome(Nome)
{
	//var ob=document.getElementById("FN2");
//	var partes=Nome.split(" ");
//ob.value=Nome+"\n";
	var retorno="";
	var letraant="";
	var palavra="";
	for (var c=0;c<Nome.length;c++)
	{
	 var letra=Nome.charAt(c);
	 if (letra==" " && palavra=="")
	 	{
	 	letra="";		
		}
	palavra=palavra+letra;
	 if (letra==" " || (c+1)==Nome.length)
	 	{
		
		if (Trim(palavra).length>3 || retorno=="")
		palavra=palavra.charAt(0).toUpperCase()+palavra.substring(1).toLowerCase();
		else 
		palavra=palavra.charAt(0)+palavra.substring(1).toLowerCase();
		retorno+=palavra;
//ob.value+=palavra+"\n";
palavra="";
		}	
	}
return retorno
}		
function ValidaNome(Nome,diferentes,Excecao,partes)
{
	Nome=Nome.toUpperCase();
	Excecao=Excecao.toUpperCase();
	
	
//	var ob=document.getElementById("FN2");
//	var partes=Nome.split(" ");
//ob.value=Nome+"\n";
	var letraant="";
	var letra2="";
	var letra3="";
	var letras="";
 	var iguais=1;
	var retorno="";
	var reg=new RegExp(Excecao);
	for (var c=0;c<Nome.length;c++)
	{
	 var letra=Nome.charAt(c);

	 if (letras.indexOf(letra)==-1) letras+=letra;
	 if (letra==letraant)
	 	{
	 	iguais++;
		if (iguais>partes)
			{
			var palavra="";
		for (var i=0;i<iguais;i++)
			palavra+=letra;
			
			if (!reg.test(palavra) || palavra.length>3)
			{
			if (palavra==" ") palavra="espa�os";
			retorno= "favor corrigir os <u><b>"+palavra+"</b></u> repetidos!"
			break;
			} //else retorno= " de <u><b>"+iguais+palavra+"</b></u> � permitida!"

			}
		}
		else  {iguais=1;}
	 
	 letraant=letra;
 

	}
	
	if (retorno=="" && letras.length<diferentes)
		retorno="entrada incorreta!"
 
 return retorno;
}	
        function ValidaCPF(CPF,MSG)
{
dig_1 = 0;
dig_2 = 0;
controle_1 = 10;
controle_2 = 11;
lsucesso = 1;
numero=CPF;
     
	if (numero.length != 11 || numero == "00000000000" || numero == "11111111111" ||
		numero == "22222222222" ||	numero == "33333333333" || numero == "44444444444" ||
		numero == "55555555555" || numero == "66666666666" || numero == "77777777777" ||
		numero == "88888888888" || numero == "99999999999")
{
return false;
}
else
{
for (i=0 ; i < 9 ; i++)
{
dig_1 = dig_1 + parseInt(numero.substring(i, i+1) * controle_1);
controle_1 = controle_1 - 1;
}
resto = dig_1 % 11;
dig_1 = 11 - resto;

if ((resto == 0) || (resto == 1))
dig_1 = 0;

for ( i=0 ; i < 9 ; i++)
{
dig_2 = dig_2 + parseInt(numero.substring(i, i + 1) * controle_2);
controle_2 = controle_2 - 1;
}

dig_2 = dig_2 + 2 * dig_1;
resto = dig_2 % 11;
dig_2 = 11 - resto;

if ((resto == 0) || (resto == 1))
dig_2 = 0;

dig_ver = (dig_1 * 10) + dig_2;

if (dig_ver != parseFloat(numero.substring(numero.length-2,numero.length)))
{

	return "CPF incorreto!";

}
}
return "";
} 


function valida_cnpj(cnpj)
      {
      var numeros, digitos, soma, i, resultado, pos, tamanho, digitos_iguais;
      digitos_iguais = 1;
      if (cnpj.length < 14 && cnpj.length < 15)
            return "CNPJ incorreto!";
		   for (i = 0; i < cnpj.length - 1; i++)
            if (cnpj.charAt(i) != cnpj.charAt(i + 1))
                  {
                  digitos_iguais = 0;
                  break;
                  }
      if (!digitos_iguais)
            {
            tamanho = cnpj.length - 2
            numeros = cnpj.substring(0,tamanho);
            digitos = cnpj.substring(tamanho);
            soma = 0;
            pos = tamanho - 7;
            for (i = tamanho; i >= 1; i--)
                  {
                  soma += numeros.charAt(tamanho - i) * pos--;
                  if (pos < 2)
                        pos = 9;
                  }
            resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
            if (resultado != digitos.charAt(0))
                  return "CNPJ incorreto!";
            tamanho = tamanho + 1;
            numeros = cnpj.substring(0,tamanho);
            soma = 0;
            pos = tamanho - 7;
            for (i = tamanho; i >= 1; i--)
                  {
                  soma += numeros.charAt(tamanho - i) * pos--;
                  if (pos < 2)
                        pos = 9;
                  }
            resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
            if (resultado != digitos.charAt(1))
                  return "CNPJ inv�lido!";
            return "";
            }
      else
            return "CNPJ incorreto!";
      } 
function valida_data(digData) {    
    var bissexto = 0;  
	var data = digData;
	var tam = data.length;
	if (tam == 10)         
	{                
	var dia = data.substr(0,2)                
	var mes = data.substr(3,2)               
	 var ano = data.substr(6,4)                
	 if ((ano > 1900)||(ano < 2100))                
	 {                        switch (mes)                         
	 							{                                
								case '01':                                
								case '03':                                
								case '05':                                
								case '07':                               
								case '08':                               
								case '10':                                
								case '12':                                       
								if  (dia <= 31)                                         
									{                                                
									return '';                                        
									}                                       
									 break                                                               
								case '04':                                             
								case '06':                                
								case '09':                                
								 case '11':                                       
									    if  (dia <= 30)                                         
										{                                                
										return '';                                        }                                       
										 break  ;                              
										 case '02':                                        /* Validando ano Bissexto / fevereiro / dia */                                         
										 if ((ano % 4 == 0) || (ano % 100 == 0) || (ano % 400 == 0))                                         
										 {                                                 
										 bissexto = 1;                                         
										 }                                        
										  if ((bissexto == 1) && (dia <= 29))                                         
										  {                                                
										   return "";                                                                     
										   }                                        
										    if ((bissexto != 1) && (dia <= 28))                                         
											{                                                
											return "";                                         
											}                                                              
											 break                                                                   
											 }                
											 }        
											 }               
											 return "erro";        

}	
function SHOW(obj,bCerto)
{

if (obj && obj.style)
{
var classe=obj.className;
var posicao=classe.substr(classe.length-1,classe.length);
 
if (bCerto && posicao!='1')
	{
	obj.className=classe+"1"; 									
	} 
	else if (!bCerto && posicao=='1')	
	{
		obj.className=classe.substr(0,classe.length-1);
 								
 	}
 		 
}	
	}  
function Notifica(obj,bCerto)
{

if (obj && obj.style)
{
if (bCerto)	
	{
	obj.style.background=corOkFundo;
	obj.style.color=corOkFonte;									
	} else
	{
	obj.style.background=corErroFundo;
	obj.style.color=corErroFonte;									
	}	
}	
	}
	
 

function ValidaRADIOBUTTON2( container )
{
        var radios = container.getElementsByTagName('input');
        for( var i=0; i<radios.length; i++ )
        {  	 
                if( radios[i].type=='radio' && radios[i].checked )
                        return true;
        }
        return false;
}

function ValidaForm()
{ //v4.0
  var i,p,q,nm,test,num,min,max;
  var errors='';
  var args=ValidaForm.arguments;
   if (args.length==2)
  	    {
			var campos=("x,"+args[1]).split(',');
			campos[0]=args[0];
			args=campos;  
			
			
		}
		
  if (args.length>1)
  {
  var F=args[0];
  var obj=null;
  var objMSK=null;
  var incremento=2;
  var Legenda=false;
  if (args[2].length<3 && args[2].charAt(0) == 'R')
  	Legenda=false;
	else Legenda=true;
  if (Legenda) incremento=3;
   for (i=1; i<(args.length-1); i+=incremento) 
	{ 
	if (Legenda){
		test=args[i+2];
		val=PegaObjeto(args[i]);
		if (val==null)	val=document.getElementById(args[i]);
		val2=PegaObjeto(args[i]+"MSK");
		nm=args[i+1];
	} else 
		{		test=args[i+1]; 
				val=PegaObjeto(args[i]);
				if (val==null)	val=document.getElementById(args[i]);
				val2=PegaObjeto(args[i]+"MSK");
				nm=args[i];
			}
		obj=val;
		
		objMSK=val2;	

 		    if (val) 
			{ 
			
			if ((val=val.value)!="") 
				{
 				if (test.charAt(0) == 'R') 
					{
						Notifica(obj,true);
						Notifica(objMSK,true);								
					}
					if (test.indexOf('B')!=-1) 
					{	 
						var OB=obj;
				
					  if (!ValidaRADIOBUTTON2(obj))	
					  	{
						 
					     errors+='Pergunta '+args[i+1]+' deve ser respondida.\n';
						 Notifica(OB,false);
						}
						else {
							Notifica(OB,true);
							}
					} else if (test.indexOf('E')!=-1) 
					{ 
				        if (validaEmail(val)!="") 
						{
						errors+=' '+nm+' - email incorreto.\n';		
						Notifica(obj,false);
						Notifica(objMSK,false);
						}
						else 
							{
						Notifica(obj,true);
						Notifica(objMSK,true);								
							}
					} else
			     
			      if (test.indexOf('C')!=-1) 
					{ 
      					p=ValidaCPF(obj.value,true);				
				        if (p!="")
						{
						errors+=nm+''+obj.value+' informado incorreto. Verifique por favor !\n'; //nm
 						Notifica(obj,false);
						Notifica(objMSK,false);
							
							//Marca(obj);							
						}
						else 
							{
						Notifica(obj,true);
						Notifica(objMSK,true);
							}						
					} else
if (test.indexOf('J')!=-1) 
					{ 

					 p=formataCgc(obj);							
				        if (p!="")
						{
						errors+=nm+''+obj.value+' informado incorreto. Verifique por favor !\n'; //nm
 						Notifica(obj,false);
						Notifica(objMSK,false);
						}
						else 
							{
						Notifica(obj,true);
						Notifica(objMSK,true);
							}						
					}		else			
if (test.indexOf('D')!=-1) 
					{ 
			
      					p=valida_data(obj.value,true);				
				        if (p!="")
						{
						errors+=nm+': '+obj.value+' inv�lida. Verifique por favor !\n'; //nm
 						Notifica(obj,false);
						Notifica(objMSK,false);
						 
							
							//Marca(obj);							
						}
						else 
							{
						Notifica(obj,true);
						Notifica(objMSK,true);
							}						
					}					
	 				else if (test!='R') 
						{		 					
					        if (test.charAt(0)=='V' && isNaN(val)) 
							{
							errors+=' '+nm+' - deve ser um valor. Favor utilizar ponto(.) como separador no lugar de virgula!\n';
						Notifica(obj,false);
						Notifica(objMSK,false);
							//Marca(obj);								
							}
							else 
								{
						Notifica(obj,true);
						Notifica(objMSK,true);
								}							
				        	if (test.indexOf('V<') !=-1) 
							{ 
							   p=test.indexOf(':');
          						   min=eval(test.substring(3,p));
						           max=eval(test.substring(p+1));
          						  if (val<min || max<val) 
								  {
								errors+=' '+nm+' - o valor deve estar entre '+min+' e '+max+'.\n';
						Notifica(obj,false);
						Notifica(objMSK,false);
								//Marca(obj);									
							  	  }
 								  else 
									{
						Notifica(obj,true);
						Notifica(objMSK,true);
									}								
						    } 
						} 
					} 
					else {	 			


							if (test.charAt(0) == 'R') 
							{
							errors += ''+nm+' - deve ser preenchido.\n'; 
						Notifica(obj,false);
						Notifica(objMSK,false);
							//Marca(obj);							
							}					
						}
				}
  			} 
if (errors) 
	{
	alert(errors+'\nTodo campo em destaque deve ser preenchido! \n Por Favor informe os dados para estes campos');
	return false;
	}
	else 
		return true;
  } else return true;
}

function ValidaDia(OBJ,Padrao)
{
var Dia=OBJ.value;
 if (isNaN(Dia)) 
 	{
	alert('valor incorreto!\n'); 
	OBJ.value=Padrao;
	OBJ.style.background='red';
	OBJ.style.color='yellow';
	}
else if (Dia<0 || Dia>31)
	{ 
	OBJ.value=Padrao;
	alert('o valor deve estar entre 1 e 31!');
	OBJ.style.background='red';
	OBJ.style.color='yellow';	
	}
else 
    {
	OBJ.style.background='white';
	OBJ.style.color='black';		
	}	
if (Dia<10) OBJ.value="0"+eval(OBJ.value);	
}
function ValidaAno(OBJ,Padrao)
{
var Ano=OBJ.value;
 if (isNaN(Ano)) 
 	{
	alert('valor incorreto!\n'); 
	OBJ.value=Padrao;
	OBJ.style.background='red';
	OBJ.style.color='yellow';	
	}
else if (Ano<1500)
	{ 
	OBJ.value=Padrao;
	alert('o valor deve ser maior que 1500!');
	OBJ.style.background='red';
	OBJ.style.color='yellow';	
	}
else 
    {
	OBJ.style.background='white';
	OBJ.style.color='black';		
	}	
	
}
// Formata o campo Agencia
function formataAgenciaConta(campo){
	campo.value = filtraCampo(campo);
	vr = campo.value;
	tam = vr.length;
	if ( tam <= 1 )
		campo.value = vr;
	if ( tam > 1 ) 
		campo.value = vr.substr(0, tam-1 ) + '-' + vr.substr(tam-1, tam); 
}

// Formata data no padr?o DDMMAAAA
function formataData(campo){
	campo.value = filtraCampo(campo);
	vr = campo.value;
	tam = vr.length;

	if ( tam > 2 && tam < 5 )
		campo.value = vr.substr( 0, tam - 2  ) + '-' + vr.substr( tam - 2, tam );
	if ( tam >= 5 && tam <= 10 )
		campo.value = vr.substr( 0, 2 ) + '-' + vr.substr( 2, 2 ) + '-' + vr.substr( 4, 4 ); 

}

// Formata hora no padrao HH:MM
function formataHora(campo,teclapres) {
	var tecla = teclapres.keyCode;
	campo.value = filtraCampo(campo);
	vr = campo.value;
	vr = vr.replace( ".", "" );
	vr = vr.replace( ":", "" );
	vr = vr.replace( ":", "" );
	tam = vr.length + 1;

	if ( tecla != 9 && tecla != 8 ){
		if ( tam > 2 && tam < 5 )
			campo.value = vr.substr( 0, tam - 2  ) + ':' + vr.substr( tam - 2, tam );
	}
}
// limpa todos os caracteres especiais do campo solicitado
function filtraCampo(campo){
	var s = "";
	var cp = "";
	vr = campo.value;
	tam = vr.length;
	for (i = 0; i < tam ; i++) {  
		if (vr.substring(i,i + 1) != "/" && vr.substring(i,i + 1) != "-" && vr.substring(i,i + 1) != "."  && vr.substring(i,i + 1) != "," ){
		 	s = s + vr.substring(i,i + 1);}
	}
	campo.value = s;
	return cp = campo.value
}
// Formata o campo valor

function formataValor(campo) {
	
	if (campo)
	{
	vr = filtraCampo(campo);
	vr=TrocaTexto(vr,' ','');
	vr2=vr;

	tam = vr.length;
 if (tam==0 || vr==0) 
 	{
	campo.style.backgroundImage='url(https://www.virtualclass.com.br/repositorio/css/original/v_emp.gif)';
	campo.style.backgroundPosition="right";
	campo.style.backgroundRepeat="no-repeat";

	}
	if ( tam <= 2 ){ 
 		campo.value = vr ;
		vr2="0."+vr;
		 } else {	
		vr2 = vr.substr( 0, tam - 2 ) + '.' + vr.substr( tam - 2, tam ) ;
 	if ( (tam > 2) && (tam <= 5) ){
		
 		vr = vr.substr( 0, tam - 2 ) + ',' + vr.substr( tam - 2, tam ) ; }
 	else if ( (tam >= 6) && (tam <= 8) ){
 		vr = vr.substr( 0, tam - 5 ) + '.' + vr.substr( tam - 5, 3 ) + ',' + vr.substr( tam - 2, tam ) ; }
 	else if ( (tam >= 9) && (tam <= 11) ){
 		vr = vr.substr( 0, tam - 8 ) + '.' + vr.substr( tam - 8, 3 ) + '.' + vr.substr( tam - 5, 3 ) + ',' + vr.substr( tam - 2, tam ) ; }
 	else if ( (tam >= 12) && (tam <= 14) ){
 		vr = vr.substr( 0, tam - 11 ) + '.' + vr.substr( tam - 11, 3 ) + '.' + vr.substr( tam - 8, 3 ) + '.' + vr.substr( tam - 5, 3 ) + ',' + vr.substr( tam - 2, tam ) ; }
 	else if ( (tam >= 15) && (tam <= 18) ){
 		vr = vr.substr( 0, tam - 14 ) + '.' + vr.substr( tam - 14, 3 ) + '.' + vr.substr( tam - 11, 3 ) + '.' + vr.substr( tam - 8, 3 ) + '.' + vr.substr( tam - 5, 3 ) + ',' + vr.substr( tam - 2, tam ) ;}
		}
 	campo.value =vr;

try { parseFloat(vr2);
	 	campo.style.backgroundImage='url(https://www.virtualclass.com.br/repositorio/css/original/v_ok.gif)';
	campo.style.backgroundPosition="right";
	campo.style.backgroundRepeat="no-repeat";

										 
} catch (e) {
									 	campo.style.backgroundImage='url(https://www.virtualclass.com.br/repositorio/css/original/v_err.gif)';
	campo.style.backgroundPosition="right";
	campo.style.backgroundRepeat="no-repeat";
 							}
	}
}

// Formata o campo valor
function formataNota(campo) {
	campo.value = filtraCampo(campo);
	vr = campo.value;
	tam = vr.length;

	if ( tam <= 2 ){ 
 		campo.value = vr ; }
 	if ( (tam > 2) && (tam <= 5) ){
 		campo.value = vr.substr( 0, tam - 2 ) + '.' + vr.substr( tam - 2, tam ) ; }
 	if ( (tam >= 6) && (tam <= 8) ){
 		campo.value = vr.substr( 0, tam - 5 ) + '' + vr.substr( tam - 5, 3 ) + '.' + vr.substr( tam - 2, tam ) ; }
 	if ( (tam >= 9) && (tam <= 11) ){
 		campo.value = vr.substr( 0, tam - 8 ) + '' + vr.substr( tam - 8, 3 ) + '' + vr.substr( tam - 5, 3 ) + '.' + vr.substr( tam - 2, tam ) ; }
 		
}
// Formata o campo valor
function formataNumerico(campo,minimo) {
	campo.value = filtraCampo(campo);
	vr = campo.value;
	tam = vr.length;
	try { parseFloat(vr);
	 	campo.style.backgroundImage='url(https://www.virtualclass.com.br/repositorio/css/original/v_ok.gif)';
	campo.style.backgroundPosition="right";
	campo.style.backgroundRepeat="no-repeat";
		if (vr>minimo)
		return '';
		else return 'x';

										 
} catch (e) {
									 	campo.style.backgroundImage='url(https://www.virtualclass.com.br/repositorio/css/original/v_err.gif)';
	campo.style.backgroundPosition="right";
	campo.style.backgroundRepeat="no-repeat";
	return "x"; 							
	}
	
}

 
function RetornaNumeroInteiro(valor,quant)
{
var v=valor;
for (var c=v.length;c<quant;c++)
v="0"+v;
return v;			
}
function formataMesAno(campo){
	campo.value = filtraCampo(campo);
	vr = campo.value;
	tam = vr.length;

	if ( tam > 2 && tam < 5 )
		campo.value = vr.substr( 0, tam - 2  ) + '/' + vr.substr( tam - 2, tam );
	if ( tam >= 5 && tam <= 10 )
		campo.value = vr.substr( 0, 2 ) + '/' + vr.substr( 2, 4 ); 
}

function formataCgc(campo) {
 
	vr = filtraCampo(campo);
	tam = vr.length;

	if ( tam <= 2 ){ 
 		campo.value = vr ; }
 	if ( (tam > 2) && (tam <= 6) ){
 		campo.value = vr.substr( 0, tam - 2 ) + '-' + vr.substr( tam - 2, tam ) ; }
 	if ( (tam >= 7) && (tam <= 9) ){
 		campo.value = vr.substr( 0, tam - 6 ) + '/' + vr.substr( tam - 6, 4 ) + '-' + vr.substr( tam - 2, tam ) ; }
 	if ( (tam >= 10) && (tam <= 12) ){
 		campo.value = vr.substr( 0, tam - 9 ) + '.' + vr.substr( tam - 9, 3 ) + '/' + vr.substr( tam - 6, 4 ) + '-' + vr.substr( tam - 2, tam ) ; }
 	if ( (tam >= 13) && (tam <= 14) ){
 		campo.value = vr.substr( 0, tam - 12 ) + '.' + vr.substr( tam - 12, 3 ) + '.' + vr.substr( tam - 9, 3 ) + '/' + vr.substr( tam - 6, 4 ) + '-' + vr.substr( tam - 2, tam ) ; }
 	if ( (tam >= 15) && (tam <= 17) ){
 		campo.value = vr.substr( 0, tam - 14 ) + '.' + vr.substr( tam - 14, 3 ) + '.' + vr.substr( tam - 11, 3 ) + '.' + vr.substr( tam - 8, 3 ) + '.' + vr.substr( tam - 5, 3 ) + '-' + vr.substr( tam - 2, tam ) ;}
	 
		if (vr.length==14)
		{
		var p=valida_cnpj(vr);		
		if (p=="")
						{
 	 	campo.style.backgroundImage='url(https://www.virtualclass.com.br/repositorio/css/original/v_ok.gif)';
	campo.style.backgroundPosition="right";
	campo.style.backgroundRepeat="no-repeat";						
						return '';
						}
						else 
							{
									 	campo.style.backgroundImage='url(https://www.virtualclass.com.br/repositorio/css/original/v_err.gif)';
	campo.style.backgroundPosition="right";
	campo.style.backgroundRepeat="no-repeat";
								return 'x';
 							}
		} else {
				 	campo.style.backgroundImage='url(https://www.virtualclass.com.br/repositorio/css/original/v_emp.gif)';
	campo.style.backgroundPosition="right";
	campo.style.backgroundRepeat="no-repeat";
	return 'x';}
		
}

function formataCPF(campo){
	campo.value = filtraCampo(campo);
	vr = campo.value;
	tam = vr.length ;
	if ( tam <= 2 ){
 		campo.value = vr ;}
	if ( tam > 2 && tam <= 5 ){
		campo.value = vr.substr( 0, tam - 2 ) + '-' + vr.substr( tam - 2, tam );}
	if ( tam >= 6 && tam <= 8 ){
		campo.value = vr.substr( 0, tam - 5 ) + '.' + vr.substr(tam - 5, 3 ) + '-' + vr.substr( tam - 2, tam );}
	if ( tam >= 9 && tam <= 11 ){
		campo.value = vr.substr( 0, tam - 8 ) + '.' + vr.substr( tam - 8, 3 ) + '.' + vr.substr(tam - 5, 3 ) + '-' + vr.substr( tam - 2, tam );}

}

function formataPercentual(campo) {
	campo.value = filtraCampo(campo);
	vr = campo.value;
	tam = vr.length;

	if ( tam <= 3 ){ 
 		campo.value = vr ; }
 	if ( (tam > 3) && (tam <= 6) ){
 		campo.value = vr.substr( 0, tam - 3 ) + ',' + vr.substr( tam - 3, tam ) ; }	
}

function formataTelefone(campo) {
	campo.value = filtraCampo(campo);
	vr = campo.value;
	tam = vr.length;

	if ( tam <= 4 )
		campo.value = vr;
	if ( tam > 4 ) 
		campo.value = vr.substr(0, tam-4 ) + '-' + vr.substr(tam-4, tam);
}
// Formata o campo Agencia
function formataAgenciaConta(campo){
	campo.value = filtraCampo(campo);
	vr = campo.value;
	tam = vr.length;
	if ( tam <= 1 )
		campo.value = vr;
	if ( tam > 1 ) 
		campo.value = vr.substr(0, tam-1 ) + '-' + vr.substr(tam-1, tam); 
}
function indiceAuto(f)
{
	if (f==null || f=='' ) f='form1';
 	var form=document.forms.item(f);
	if (form!=null) 
	{
	var elements=form.elements;
	var P=0;
	for (i=0;i<elements.length;i++) 
			{
			var sTagType = elements[i].getAttribute("type");
			
			if (sTagType=="text" || sTagType=="select-one" || sTagType=="textarea-one")
				{
					P++;
				elements[i].tabIndex=P;
				}
			}
	}
}
function saltaCampo(f,campo,tamanhoMaximo,indice,teclapres){
	var vr = campo.value;
	var tam = vr.length;
	var nome=campo.name;
	var tecla = teclapres.keyCode;
	if (f=='') f='form1';
 	var form=document.forms.item(f);
	 
	if (indice==null || indice==0)
		indice=campo.tabIndex;
	var elements;
	if (form!=null) elements=form.elements;
	
	if (elements!=null && ((tecla==13  && tamanhoMaximo==0) || (tam>=tamanhoMaximo && tamanhoMaximo>0)) && typeof(elements[indice])!='undefined'){
var incremento=0; 
var Achou=false;
		for (var x=0;x<30;x++)
		{
			
			if (Achou) break;
			incremento++;
		for (i=0;i<elements.length;i++) {
			
			if (incremento==30 && i>0 && elements[i-1].name==nome)
			{try {elements[i].focus();break;} catch (e) {};} else
			if (elements[i].tabIndex==indice+incremento){
			Achou=true;
				try {elements[i].focus();break;} catch (e) {};
			}
		}}
	}
}
function validaEmail(mail){       
 var er = new RegExp(/^[A-Za-z0-9_\-\.]+@[A-Za-z0-9_\-\.]{2,}\.[A-Za-z0-9]{2,}(\.[A-Za-z0-9])?/);      
   if(typeof(mail) == "string"){            
       if(mail="" || er.test(mail)){ 
	   return ''; 
	   }    
	       }
	else if(typeof(mail) == "object"){   
						if (mail.value=="") 
						{
					    	mail.style.backgroundImage='url(https://www.virtualclass.com.br/repositorio/css/original/v_emp.gif)';
	mail.style.backgroundPosition="right";
	mail.style.backgroundRepeat="no-repeat";													
							}
						else {
		               if(er.test(mail.value)){ 
					   
					    	mail.style.backgroundImage='url(https://www.virtualclass.com.br/repositorio/css/original/v_ok.gif)';
	mail.style.backgroundPosition="right";
	mail.style.backgroundRepeat="no-repeat";						
      
					    return '';  
						      } 
								else{  
								mail.style.backgroundImage='url(https://www.virtualclass.com.br/repositorio/css/original/v_err.gif)';
	mail.style.backgroundPosition="right";
	mail.style.backgroundRepeat="no-repeat";
								return 'inv�lido';
                					}}
	}
}