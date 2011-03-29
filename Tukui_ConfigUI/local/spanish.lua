if GetLocale() == "esES" then

	-- update needed msg
	TukuiL.option_update = "You need to update your Tukui ConfigUI addon because of Tukui latest changes, please visit www.tukui.org"
	
	-- general
	TukuiL.option_general = "General"
	TukuiL.option_general_uiscale = "Escala UI Automatica"
	TukuiL.option_general_override = "Usar reso Alta en monitor de reso Baja"
	TukuiL.option_general_multisample = "Proteccion de Multisample (margen 1xp limpio)"
	TukuiL.option_general_customuiscale = "Escala UI (solo si escala automatica esta apagado)"
	TukuiL.option_general_backdropcolor = "Define el color por defecto del fondo de los paneles"
	TukuiL.option_general_bordercolor = "Define el color por defecto de los paneles"

	-- nameplate
	TukuiL.option_nameplates = "Placas de nombre"
	TukuiL.option_nameplates_enable = "Activar placas de nombre"
	TukuiL.option_nameplates_enhancethreat = "Activar visor de amenaza, cambia automáticamente según tu rol: \n Tanque - Verde (amenaza) Rojo (sin amenaza) DPS - Verde (sin amenaza) Rojo (amenaza)"
	TukuiL.option_nameplates_showhealth = "Mostrar vida en las placas de nombre"
 	TukuiL.option_nameplates_combat = "Mostrar las placas de nombre de los enemigos sólo en combate"
	TukuiL.option_nameplates_goodcolor = "Color de buena amenaza, dependiendo si eres Tanque, DPS o Healer."
	TukuiL.option_nameplates_badcolor = "Color de mala amenaza, dependiendo si eres Tanque, DPS o Healer."
	TukuiL.option_nameplates_transitioncolor = "Color de Perdida o Ganancia de Amenaza"
 
	-- merchant
	TukuiL.option_merchant = "Comerciante"
	TukuiL.option_merchant_autosell = "Vender los objetos grises automaticamente"
	TukuiL.option_merchant_autorepair = "Reparar los objetos automaticamente"
	TukuiL.option_merchant_sellmisc = "Vender automaticamente determinados objetos (no grises) determinados como basura."
 
	-- bags
	TukuiL.option_bags = "Bolsas"
	TukuiL.option_bags_enable = "Habilitar bolsa todo-en-uno"
 
	-- datatext
	TukuiL.option_datatext = "Texto de Data"
	TukuiL.option_datatext_24h = "Habilitar Tiempo en 24h"
	TukuiL.option_datatext_localtime = "Usar Tiempo local en vez de Tiempo del Servidor"
	TukuiL.option_datatext_bg = "Habilitar Estadísticas de Campos de Batalla"
	TukuiL.option_datatext_hps = "Posición de Curas por Segundo"
	TukuiL.option_datatext_guild = "Posición de Hermandad"
	TukuiL.option_datatext_arp = "Posición de penetración de armadura"
	TukuiL.option_datatext_mem = "Posición de memoria"
	TukuiL.option_datatext_bags = "Posición de bolsas"
	TukuiL.option_datatext_fontsize = "Tamaño de el Texto"
	TukuiL.option_datatext_fps_ms = "Posición de MS y FPS"
	TukuiL.option_datatext_armor = "Posición de Armadura"
	TukuiL.option_datatext_avd = "Posición de Evitación"
	TukuiL.option_datatext_power = "Posición de Poder"
	TukuiL.option_datatext_haste = "Posición de Precipitación"
	TukuiL.option_datatext_friend = "Posición de Amigos"
	TukuiL.option_datatext_time = "Posición del Tiempo"
	TukuiL.option_datatext_gold = "Posición del Oro"
	TukuiL.option_datatext_dps = "Posición de Daño por segundo"
	TukuiL.option_datatext_crit = "Posición del Crítico"
	TukuiL.option_datatext_dur = "Posición de la Durabilidad"
	TukuiL.option_datatext_currency = "Posición de las Monedas (0 para desactivar)"
	TukuiL.option_datatext_micromenu = "Posición Micro Menu (0 para desactiva)"
	TukuiL.option_datatext_hit = "Posición Índice de Golpe (0 para desactiva)"
	TukuiL.option_datatext_mastery = "Posición Maestría (0 para desactiva)"	
 
	-- unit frames
	TukuiL.option_unitframes_unitframes = "Marcos de Unidad"
	TukuiL.option_unitframes_combatfeedback = "Mostrar Daño/Curas en los Marcos de Unidad"
	TukuiL.option_unitframes_runebar = "Habilitar barra de runas para Caballeros de la Muerte"
	TukuiL.option_unitframes_auratimer = "Habilitar temporizador para Auras"
	TukuiL.option_unitframes_totembar = "Habilitar barras de Totems para Chamánes"
	TukuiL.option_unitframes_totalhpmp = "Mostrar Vida/Mana Total"
	TukuiL.option_unitframes_playerparty = "Mostrar a ti mismo en Grupos"
	TukuiL.option_unitframes_aurawatch = "Habilitar PVE vigilancia de Auras (Solo para Grid)"
	TukuiL.option_unitframes_castbar = "Habilitar barra de lanzamiento"
	TukuiL.option_unitframes_targetaura = "Habilitar auras del Objetivo"
	TukuiL.option_unitframes_saveperchar = "Guardar Marcos de Unidad para solo 1 personaje"
	TukuiL.option_unitframes_playeraggro = "Enseñar tu amenaza"
	TukuiL.option_unitframes_smooth = "Habilitar barra lisa"
	TukuiL.option_unitframes_portrait = "Mostrar retratos"
	TukuiL.option_unitframes_enable = "Habilitar TukUI Marcos de Unidad"
	TukuiL.option_unitframes_enemypower = "Habilitar maná solo para el Enemigo"
	TukuiL.option_unitframes_gridonly = "Habilitar mana solo para el Enemigo"
	TukuiL.option_unitframes_healcomm = "Habilitar healcomm"
	TukuiL.option_unitframes_focusdebuff = "Habilitar Perjuicios en tu Foco"
	TukuiL.option_unitframes_raidaggro = "Habilitar amenaza en tu Grupo/Banda"
	TukuiL.option_unitframes_boss = "Habilitar Marcos de Unidad para Jefes"
	TukuiL.option_unitframes_enemyhostilitycolor = "Colorear Marcos de Unidad de enemigos por Hostilidad"
	TukuiL.option_unitframes_hpvertical = "Mostrar Barra de Vida Vertical para Grid"
	TukuiL.option_unitframes_symbol = "Mostrar símbolos en Grupos/Banda"
	TukuiL.option_unitframes_threatbar = "Habilitar barra de Aggro"
	TukuiL.option_unitframes_enablerange = "Mostrar alfa en Grupos/Banda"
	TukuiL.option_unitframes_focus = "Habilitar el Objetivo de tu Foco"
	TukuiL.option_unitframes_latency = "Mostrar MS en tu Barra de lanzamiento"
	TukuiL.option_unitframes_icon = "Mostrar iconos en tu barra de lanzamiento"
	TukuiL.option_unitframes_playeraura = "Habilitar un modo alternativo de Auras para el jugador"
	TukuiL.option_unitframes_aurascale = "Tamaño del texto en las Auras"
	TukuiL.option_unitframes_gridscale = "Tamaño de Grid"
	TukuiL.option_unitframes_manahigh = "Indicador de Maná alto (Para Cazadores)"
	TukuiL.option_unitframes_manalow = "Indicador de Maná bajo (Todas classes con Maná)"
	TukuiL.option_unitframes_range = "Alfa en Grupo/Banda que estan fuera de alcance"
	TukuiL.option_unitframes_maintank = "Habilitar Tanque Principal"
	TukuiL.option_unitframes_mainassist = "Habilitar Ayudadores Principales"
	TukuiL.option_unitframes_unicolor = "Habilitar Tema de Color Unico (Barra de vida gris)"
	TukuiL.option_unitframes_totdebuffs = "Habilitar Perjuicios en Objetivo del Objetivo (Resolucion Alta)"
	TukuiL.option_unitframes_classbar = "Habilitar Barra de Clase"
	TukuiL.option_unitframes_weakenedsoulbar = "Habilitar Barra de Notificacion de Alma Debilitada (Sacerdote)"
	TukuiL.option_unitframes_onlyselfdebuffs = "Mostrar solo tus debuffs en el objetivo"
	TukuiL.option_unitframes_focus = "Habilitar el Blanco de tu Foco"
	TukuiL.option_unitframes_bordercolor = "Define el color por defecto del borde de los paneles"
 
	-- loot
	TukuiL.option_loot = "Botín"
	TukuiL.option_loot_enableloot = "Habilitar Ventana del Botin"
	TukuiL.option_loot_autogreed = "Habilitar Auto-Codicia para objetos verdes al Nivel 85"
	TukuiL.option_loot_enableroll = "Habilitar Ventana de Tirar Dados por Objetos"
 
	-- map
	TukuiL.option_map = "Mapa"
	TukuiL.option_map_enable = "Habilitar Mapa"
 
	-- invite
	TukuiL.option_invite = "Invitación"
	TukuiL.option_invite_autoinvite = "Auto-aceptar Invitaciones (Amigos y Hermandad solo)"
 
	-- tooltip
	TukuiL.option_tooltip = "Tooltip"
	TukuiL.option_tooltip_enable = "Habilitar Tooltip"
	TukuiL.option_tooltip_hidecombat = "Esconder tooltip en combate"
	TukuiL.option_tooltip_hidebutton = "Esconder tooltip de los Botones de Habilidad"
	TukuiL.option_tooltip_hideuf = "Esconder tooltip en Marcos de Unidad"
	TukuiL.option_tooltip_cursor = "Habilidar Tooltip en tu cursor"
 
	-- others
	TukuiL.option_others = "Otros"
	TukuiL.option_others_bg = "Habiliadr auto-liberación en Campos de Batalla"
 
	-- reminder
	TukuiL.option_reminder = "Advertencia de Auras"
	TukuiL.option_reminder_enable = "Habilitar advertencia de auras para el Jugador"
	TukuiL.option_reminder_sound = "Habilitar Sonido de Advertencia"
 
	-- error
	TukuiL.option_error = "Mensaje de Error"
	TukuiL.option_error_hide = "Esconder mensajes de error de tu pantalla"
 
	-- action bar
	TukuiL.option_actionbar = "Barras de Habilidades"
	TukuiL.option_actionbar_hidess = "Esconder barras de Totems y Cambio de forma"
	TukuiL.option_actionbar_showgrid = "Siempre enseñar Grid en barras de acciones"
	TukuiL.option_actionbar_enable = "Habilitar barras de accion de TukUI"
	TukuiL.option_actionbar_rb = "Enseñar barras derechas solo con el Raton encima"
	TukuiL.option_actionbar_hk = "Enseñar Hotkeys en los botones"
	TukuiL.option_actionbar_ssmo = "Barras de Totems y Cambiar de forma solo con el raton encima"
	TukuiL.option_actionbar_rbn = "Barras de accion bajas (1 o 2)"
	TukuiL.option_actionbar_rn = "Barras de accion derechas (1, 2 o 3)"
	TukuiL.option_actionbar_buttonsize = "Tamaño de los botones de la barra principal"
	TukuiL.option_actionbar_buttonspacing = "Espacio entre los botones de la barra principal"
	TukuiL.option_actionbar_petbuttonsize = "Tamaño de los botones de Mascota y Cambio de forma"
	
	-- quest watch frame
	TukuiL.option_quest = "Misiones"
	TukuiL.option_quest_movable = "Dejar que el Marco de misiones se mueva"
 
	-- arena
	TukuiL.option_arena = "Arena"
	TukuiL.option_arena_st = "Habilitar Rastreador de habilidades de enemigos en Arena"
	TukuiL.option_arena_uf = "Habilitar TukUI marcos de arena"
	
	-- pvp
	TukuiL.option_pvp = "JcJ"
	TukuiL.option_pvp_ii = "Habilita Iconos de Interrupción"
 
	-- cooldowns
	TukuiL.option_cooldown = "Tiempo de reutilización"
	TukuiL.option_cooldown_enable = "Habilitar numeros de tiempo de reutilización en botones"
	TukuiL.option_cooldown_th = "Colorea el tiempo de reutilización rojo cuando llega al numero X"
 
	-- chat
	TukuiL.option_chat = "Social"
	TukuiL.option_chat_enable = "Habilitar Chat de TukUI"
	TukuiL.option_chat_whispersound = "Habilitar sonido cuando recives un sussuro"
	TukuiL.option_chat_background = "Habilita el fondo del marco de chat"
	
	-- buff
	TukuiL.option_auras = "Auras"
	TukuiL.option_auras_player = "Enable Tukui Buff/Debuff Frames"
 
	-- buttons
	TukuiL.option_button_reset = "Resetear"
	TukuiL.option_button_load = "Aplicar"
	TukuiL.option_button_close = "Cerrar"
	TukuiL.option_setsavedsetttings = "Guardar opciones por personje"
	TukuiL.option_resetchar = "¿Seguro que desea reiniciar las opcioens de este personaje a las por defecto?"
	TukuiL.option_resetall = "¿Seguro que desea reiniciar TODAS las opciones a las por defecto?"
	TukuiL.option_perchar = "¿Seguro que desea cambiar la configuración 'por personaje'?"
	TukuiL.option_makeselection = "Tiene que seleccionar una opción antes de seguir con la configuración."	
end