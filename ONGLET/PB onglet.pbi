; **************************************************************************
; AUTHOR           : MicrodevWeb
; MODULE           : PB onglet
; VERSION          : 1.0
; DESIGNED WITH    : PureBasic 5.71 beta 2
; LICENCE          : creative commons CC BY-NC-SA
; **************************************************************************
DeclareModule ONGLET
  Interface LinearColors
    ; PUBLIC
    free()
    addColor(color,position.f)
  EndInterface
  Interface Panel
    ; GETTERS
    getTitle.s()
    isActif.b()
    getData()
    ; SETTER
    setTitle(title.s)
    setActif(state.b)
    setData(pData)
    ; PUBLIC
    setCallback(callback)
    addContent(content)
  EndInterface
  Interface Onglet
    ; GETTERS
    getLinear()
    getActiveLnear()
    ; SETTERS
    setPanelFont(font)
    ; PUBLIC
    free()
    build()
    addPanel(panel)
  EndInterface
  Interface __content
    ; GETTERS
    getData()
    ; SETTERS
    setData(pData)
    setCallback(callback)
    setHelpText(text.s)
    ; PUBLIC
    setShorcut(shortCut)
  EndInterface
  Interface Icon Extends __content
    ; GETTERS
    isDisable()
    ; SETTERS
    setDisable(state.b)
  ; PUBLIC
  EndInterface
  
  Declare newLinear(horiszontal.b = #False)
  Declare newOnglet(containerId,backGroundColor,innerBackColor,innerFrontColor,panelTitleColor,*linearColor,*linearActiveColor)
  Declare newPanel(title.s,actif.b = #False)
  Declare newIcon(image)
EndDeclareModule
Module ONGLET
  EnableExplicit
  UsePNGImageDecoder()
  
  XIncludeFile "CLASSES/Structure.pbi"
  Declare CONT_super(*this._content,*s_daughter,*E_daughter)
  XIncludeFile "CLASSES/Content.pbi"
  XIncludeFile "CLASSES/Icon.pbi"
  XIncludeFile "CLASSES/Linear.pbi"
  XIncludeFile "CLASSES/Panel.pbi"
  XIncludeFile "CLASSES/Onglet.pbi"
EndModule
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 44
; FirstLine = 5
; Folding = x-
; EnableXP