programa
{
	
inclua biblioteca Graficos --> g
	inclua biblioteca Util --> u 
	inclua biblioteca Teclado --> t

	const inteiro LARGURA_JANELA = 600
	const inteiro ALTURA_JANELA = 600

	inteiro xcabeca_cobra = 275
	inteiro ycabeca_cobra = 275

	inteiro xcauda_cobra[600]
	inteiro ycauda_cobra[600]

	inteiro xposicoes_comida[24] = 
	{0,25,50,75,100,125,150,175,200,225,250,275,300,
	325,350,375,400,425,450,475,500,525,550,575}
	inteiro yposicoes_comida[22] = 
	{50,75,100,125,150,175,200,225,250,275,300,
	325,350,375,400,425,450,475,500,525,550,575}

	inteiro xcomida = 300
	inteiro ycomida = 300
	inteiro tamanho_cobra = 2
	

	inteiro delay = 120

	inteiro pontuacao = 0

	logico direita=falso, esquerda=falso,para_cima = falso,para_baixo=falso
	 
	funcao inicio()
	{
		montar_janela()
		enquanto (verdadeiro){
			pintar_janela()
			desenhar_painel()
			direcionar_cobra()
			atualizar_posicoes_cobra()
			mover_cobra()
			atualizar_pontuacao()
			reiniciar()
			desenhar_comida()
			desenhar_cabeca_cobra()
			desenhar_cauda_cobra()
			sortear_posicao_comida()
			g.renderizar()
			u.aguarde(delay)
		}
	}
	funcao montar_janela (){
		g.iniciar_modo_grafico(verdadeiro)
		g.definir_dimensoes_janela(LARGURA_JANELA, ALTURA_JANELA)
		g.definir_titulo_janela("Jogo da cobrinha")
	}
	funcao pintar_janela(){
	g.definir_cor(g.COR_BRANCO)
	g.limpar()
	}
	funcao desenhar_painel(){
		g.definir_cor(g.COR_AZUL)
		g.desenhar_retangulo(0, 0, LARGURA_JANELA, 50, falso, verdadeiro)
		g.definir_cor(g.COR_AMARELO)
		g.definir_tamanho_texto(25.0)
		g.desenhar_texto(10, 10, "Pontuação Atual: " + pontuacao )
	}
	funcao desenhar_cabeca_cobra(){
		g.definir_cor(g.COR_PRETO)
		g.desenhar_retangulo(xcabeca_cobra, ycabeca_cobra, 25, 25, falso, verdadeiro)		
	}
	funcao direcionar_cobra(){
		se(t.tecla_pressionada(t.TECLA_SETA_DIREITA)){
			direita = verdadeiro
			esquerda = falso
			para_cima = falso
			para_baixo = falso
		}
		senao se(t.tecla_pressionada(t.TECLA_SETA_ESQUERDA)){
			esquerda = verdadeiro
			direita = falso
			para_cima = falso
			para_baixo = falso
		}
		senao se(t.tecla_pressionada(t.TECLA_SETA_ACIMA)){
			para_cima = verdadeiro
			para_baixo = falso
			esquerda = falso
			direita = falso
		}
		senao se(t.tecla_pressionada(t.TECLA_SETA_ABAIXO)){
			para_baixo = verdadeiro
			para_cima = falso
			direita = falso
			esquerda = falso
			
		}
	}
	funcao mover_cobra(){
		se(direita){
			xcabeca_cobra +=25
		}
		senao se (esquerda){
			xcabeca_cobra -=25
		}
		se(para_cima){
			ycabeca_cobra -=25
		}
		senao se (para_baixo){
			ycabeca_cobra +=25
		}
		
	}
	funcao logico cobra_bateu_parede(){
		se (xcabeca_cobra > 575 ou xcabeca_cobra < 0){
			retorne verdadeiro
		}
		senao se (ycabeca_cobra > 575 ou ycabeca_cobra < 50){
			retorne verdadeiro
		}
		senao {
			retorne falso
		}
	}
	funcao reiniciar(){
		se(cobra_bateu_parede() ou cobra_se_mordeu()){
			tamanho_cobra = 2
			xcabeca_cobra = 275
			ycabeca_cobra = 275
			direita = falso
			esquerda = falso
			para_cima = falso
			para_baixo = falso
		}
	}
	funcao logico cobra_comeu_comida(){
		se (xcabeca_cobra==xcomida e ycabeca_cobra == ycomida){
			retorne verdadeiro
		}senao{
			retorne falso
		}
	}
	funcao sortear_posicao_comida(){
		inteiro xindice = u.sorteia(0, 23)
		inteiro yindice = u.sorteia(0, 21)
		se (cobra_comeu_comida()){
			xcomida = xposicoes_comida[xindice]
			ycomida = yposicoes_comida[yindice]
		}
	}
	funcao desenhar_comida(){
		g.definir_cor(g.COR_VERMELHO)
		g.desenhar_retangulo(xcomida, ycomida, 25, 25, falso, verdadeiro)
	}
	funcao atualizar_posicoes_cobra(){
		xcauda_cobra[0] = xcabeca_cobra
		ycauda_cobra[0] = ycabeca_cobra
		para(inteiro i = 599; i > 0; i-- ){
			xcauda_cobra[i] = xcauda_cobra[i-1]
			ycauda_cobra[i] = ycauda_cobra[i-1]
		}	
	}
	funcao desenhar_cauda_cobra(){
		se(cobra_comeu_comida()){
			tamanho_cobra ++			
		}
		para(inteiro i = 0;i < tamanho_cobra; i++){
			g.desenhar_retangulo(xcauda_cobra[i], ycauda_cobra[i], 25, 25, falso, verdadeiro)
		}
	}
	funcao atualizar_pontuacao(){
		pontuacao = tamanho_cobra - 2 
	}
	funcao logico cobra_se_mordeu(){
		logico mordeu = falso
		para(inteiro i = 0; i<tamanho_cobra;i++){
			se(xcabeca_cobra == xcauda_cobra[i] e ycabeca_cobra == ycauda_cobra[i]){
				mordeu = verdadeiro
			}
		}
		retorne mordeu
	}
	
		
	
		
	
	
}
