; **************************************************************************
; AUTHOR           : MicrodevWeb
; MODULE           : PB onglet
; CLASS            : Onglet
; FILE             : Onglet.pbi
; VERSION          : 1.0
; DESIGNED WITH    : PureBasic 5.71 beta 2
; LICENCE          : creative commons CC BY-NC-SA
; **************************************************************************
;-* PRIVATE METHODS
Procedure _ONG_drawInnerBox(*this._onglet)
  With *this
    Protected.d x = 2,y = \myPanels()\myPos\y + \myPanels()\myPos\h ,w = GadgetWidth(\canvasId) - 4,h = GadgetHeight(\canvasId) - y
    AddPathBox(x,y,w,h)
    VectorSourceColor(\innerBackColor)
    FillPath()
    ; draw line
    Protected.d xl,yl
    xl = \myPanels()\myPos\x+\myPanels()\myPos\w
    yl = \myPanels()\myPos\y+\myPanels()\myPos\h
    MovePathCursor(xl,yl)
    AddPathLine(w - xl + 2,0,#PB_Path_Relative)
    AddPathLine(0,h,#PB_Path_Relative)
    AddPathLine(- w,0,#PB_Path_Relative)
    AddPathLine(0,-h,#PB_Path_Relative)
    AddPathLine(\myPanels()\myPos\x,0,#PB_Path_Relative)
    VectorSourceColor(\innerFrontColor)
    StrokePath(2)
  EndWith
EndProcedure

Procedure _ONG_draw(*this._onglet)
  With *this
    Protected m = 5
    StartVectorDrawing(ImageVectorOutput(\imageId))
    VectorSourceColor(\backGroundColor)
    FillVectorOutput()
    ; draw panel
    Protected x = 10,y = 10
    ForEach \myPanels()
      x + \myPanels()\make(\myPanels(),*this,x,y) + m
    Next
    StopVectorDrawing()
  EndWith
EndProcedure

Procedure _ONG_display(*this._onglet)
  With *this
    SetGadgetAttribute(\canvasId,#PB_Canvas_Image,ImageID(\imageId)) 
  EndWith
EndProcedure

Procedure _ONG_event()
  Protected *this._onglet = GetGadgetData(EventGadget())
  With *this
    Protected mx = GetGadgetAttribute(\canvasId,#PB_Canvas_MouseX)
    Protected my = GetGadgetAttribute(\canvasId,#PB_Canvas_MouseY)
    Select EventType()
      Case #PB_EventType_MouseEnter
        SetActiveGadget(\canvasId)
    EndSelect
    ForEach \myPanels()
      If \myPanels()\_event(\myPanels(),*this,mx,my)
        ProcedureReturn 
      EndIf
    Next
    _ONG_display(*this)
    SetGadgetAttribute(\canvasId,#PB_Canvas_Cursor,#PB_Cursor_Default)
  EndWith
EndProcedure
;}
;-* PROTECTED METHODS
Procedure _ONG_disableAllPanel(*this._onglet)
  With *this
    ForEach \myPanels()
      \myPanels()\actif = #False
    Next
  EndWith
EndProcedure
;}
;-* GETTERS METHODS
Procedure ONG_getLinear(*this._onglet)
  With *this
   ProcedureReturn \myColor
  EndWith
EndProcedure

Procedure ONG_getActiveLnear(*this._onglet)
  With *this
    ProcedureReturn \myActiveColor
  EndWith
EndProcedure
;}
;-* SETTERS METHODS
Procedure ONG_setPanelFont(*this._onglet,font)
  With *this
    \panelFont = font
  EndWith
EndProcedure
;}
;-* PUBLIC METHODS
Procedure ONG_free(*this._onglet)
  With *this
    If \imageId
      If IsImage(\imageId)
        FreeImage(\imageId)
      EndIf
    EndIf
    FreeStructure(*this)
  EndWith
EndProcedure

Procedure ONG_build(*this._onglet)
  With *this
    If Not \canvasId 
      OpenGadgetList(\containerId)
      \canvasId = CanvasGadget(#PB_Any,0,0,GadgetWidth(\containerId),GadgetHeight(\containerId),#PB_Canvas_Container|#PB_Canvas_Keyboard)
      \imageId = CreateImage(#PB_Any,GadgetWidth(\containerId),GadgetHeight(\containerId))
      CloseGadgetList()
      SetGadgetData(\canvasId,*this)
      BindGadgetEvent(\canvasId,@_ONG_event())
    EndIf
    _ONG_draw(*this)
    _ONG_display(*this)
  EndWith
EndProcedure

Procedure ONG_addPanel(*this._onglet,*panel)
  With *this
    AddElement(\myPanels())
    \myPanels() = *panel
    ProcedureReturn *panel
  EndWith
EndProcedure

;}
;-* CONSTRUCTOR
Procedure newOnglet(containerId,backGroundColor,innerBackColor,innerFrontColor,panelTitleColor,*linearColor,*linearActiveColor)
  Protected *this._onglet = AllocateStructure(_onglet)
  With *this
    \methods = ?S_onglet
    \containerId = containerId
    \backGroundColor = backGroundColor
    \panelTitleColor = panelTitleColor
    \myActiveColor = *linearActiveColor
    \innerBackColor = innerBackColor
    \innerFrontColor = innerFrontColor
    \myColor = *linearColor
    \_disableAllPanel = @_ONG_disableAllPanel()
    \panelFont = LoadFont(#PB_Any,"arial",11,#PB_Font_HighQuality|#PB_Font_Bold)
    \_drawInnerBox = @_ONG_drawInnerBox()
    ProcedureReturn *this
  EndWith
EndProcedure
;}

DataSection
  S_onglet:
  ; GETTERS
  Data.i @ONG_getLinear()
  Data.i @ONG_getActiveLnear()
  ; SETTERS
  Data.i @ONG_setPanelFont()
  ; PUBLIC
  Data.i @ONG_free()
  Data.i @ONG_build()
  Data.i @ONG_addPanel()
  E_onglet:
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 66
; FirstLine = 43
; Folding = -Dm+
; EnableXP