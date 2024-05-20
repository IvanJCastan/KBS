; TEMPLATES
(deftemplate mono
   (slot hambriento)
   (slot posicion)
   (slot sobre_suelo)
   (slot en_manos))
   
(deftemplate bananas
	(slot posicion)
	(slot consumidas))
	
(deftemplate silla
	(slot posicion)
	(slot sobre_suelo))
	
(deftemplate escritorio
	(slot posicion)
	(slot sobre_suelo))

; FACTS	
(deffacts estado-inicial
	(mono (hambriento 1) (posicion "fuera_habitacion") (sobre_suelo 1) (en_manos "nada"))
	(bananas (posicion "fondo_techo") (consumidas 0))
	(silla (posicion "centro") (sobre_suelo 1))
	(escritorio (posicion "fondo") (sobre_suelo 1)))
	
; RULES
(defrule subir-silla-escritorio
	(mono (posicion "fondo"))
	?silla <- (silla (sobre_suelo 1) (posicion "fondo"))
	(escritorio (sobre_suelo 1) (posicion "fondo"))
	=>
	(modify ?silla (sobre_suelo 0))
	(printout t "El mono sube la silla al escritorio." crlf))
	
(defrule escalar-silla-escritorio
	?mono <- (mono (posicion "fondo") (sobre_suelo 1))
	(silla (sobre_suelo 0) (posicion "fondo"))
	(escritorio (sobre_suelo 1) (posicion "fondo"))
	=>
	(modify ?mono (sobre_suelo 0))
	(printout t "El mono escala el escritorio y la silla." crlf))
	
(defrule mover-mono-silla
	?mono <- (mono (posicion "inicio"))
	(silla (sobre_suelo 1) (posicion "centro"))
	=>
	(modify ?mono (posicion "centro"))
	(printout t "El mono se mueve hacia la silla." crlf))
	
(defrule mono-hambriento
	?mono <- (mono (hambriento 1) (posicion "fuera_habitacion"))
	=>
	(modify ?mono (posicion "inicio"))
	(printout t "El mono está hambriento." crlf))

(defrule mono-no-hambriento
	(mono (hambriento 0))
	=>
	(printout t "El mono no está hambriento." crlf))
	
(defrule mono-mueve-silla-escritorio
	?mono <- (mono (posicion "centro"))
	?silla <- (silla (posicion "centro"))
	=>
	(modify ?mono (posicion "fondo"))
	(modify ?silla (posicion "fondo"))
	(printout t "El mono mueve la silla hacia el escritorio." crlf))
	
(defrule mono-alcanza-bananas
	?mono <- (mono (posicion "fondo") (sobre_suelo 0) (en_manos "nada"))
	(bananas (consumidas 0))
	=>
	(modify ?mono (en_manos "bananas"))
	(printout t "El mono alcanza las bananas." crlf))
	
(defrule mono-consume-bananas
	?mono <- (mono (en_manos "bananas"))
	?bananas <- (bananas (consumidas 0))
	=>
	(modify ?mono (hambriento 0))
	(modify ?bananas (consumidas 1))
	(printout t "El mono consume las bananas." crlf))