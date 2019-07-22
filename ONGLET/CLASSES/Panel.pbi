; **************************************************************************
; AUTHOR           : MicrodevWeb
; MODULE           : PB onglet
; CLASS            : Panel
; FILE             : Panel.pbi
; VERSION          : 1.0
; DESIGNED WITH    : PureBasic 5.71 beta 2
; LICENCE          : creative commons CC BY-NC-SA
; **************************************************************************
;-* PRIVATE METHODS
Procedure _PAN_hoverMe(*this._panel,mx,my)
  With *this\myPos
    If mx >= \x And mx <= \x + \w
      If my >= \y And my <= \y + \h
        ProcedureReturn #True
      EndIf
    EndIf
    ProcedureReturn #False
  EndWith
EndProcedure
;}
;-* PROTECTED METHODS
Procedure _PAN_make(*this._panel,*parent._onglet,x,y = 0)
  With *this
    Protected.d m = 5 ;margin
    VectorFont(FontID(*parent\panelFont))
    Protected.d wt = VectorTextWidth(\title)
    Protected.d ht = VectorTextHeight(\title)
    *parent\iconSize = GadgetHeight(*parent\canvasId) - ht - (m * 6)
    Protected.d h = ht + (m * 2)
    Protected.d w = wt + (m * 4)
    AddPathRoundBox(x,y,w,h,12)
    If \actif
      *parent\myActiveColor\_make(*parent\myActiveColor,x,y,w,h)
    Else
      *parent\myColor\_make(*parent\myColor,x,y,w,h)
    EndIf
    FillPath()
    AddPathRoundBox(x,y,w,h,12,#False)
    VectorSourceColor(*parent\innerFrontColor)
    StrokePath(2)
    Protected.d xt,yt
    xt = x + (w / 2) - (VectorTextWidth(\title) / 2)
    yt = y + (h / 2) - (VectorTextHeight(\title) / 2)
    MovePathCursor(xt,yt)
    VectorSourceColor(*parent\panelTitleColor)
    DrawVectorText(\title)
    \myPos\x = x
    \myPos\y = y
    \myPos\w = w
    \myPos\h = h
    Protected xc = 10,yc = h + m + \myPos\y
    If \actif
      *parent\_drawInnerBox(*parent)
      ForEach \myContents()
        \myContents()\make(\myContents(),*parent,*this,xc,yc)
        xc + *parent\iconSize + m
      Next
    EndIf
    
    ProcedureReturn w
  EndWith
EndProcedure

Procedure _PAN_event(*this._panel,*parent._onglet,mx,my)
  With *this 
    If \actif
      ForEach \myContents()
        If \myContents()\_post_event(\myContents(),*parent,mx,my)
          ProcedureReturn #True
        EndIf
      Next
    EndIf
    Select EventType()
      Case #PB_EventType_MouseMove
        gParaShow\on = #False
        If _PAN_hoverMe(*this,mx,my)
          If Not \actif
            SetGadgetAttribute(*parent\canvasId,#PB_Canvas_Cursor,#PB_Cursor_Hand)
            ProcedureReturn #True
          EndIf
        EndIf
      Case #PB_EventType_LeftClick
        If _PAN_hoverMe(*this,mx,my)
          If Not \actif
            *parent\_disableAllPanel(*parent)
            \actif = \actif ! 1
            Define *p.ONGLET::Onglet = *parent
            *p\build()
            If \callback
              \callback(*this)
            EndIf
          EndIf
        EndIf
    EndSelect
    ProcedureReturn #False
  EndWith
EndProcedure
;}
;-* GETTERS METHODS
Procedure.s PAN_getTitle(*this._panel)
  With *this
    ProcedureReturn \title
  EndWith
EndProcedure

Procedure.b PAN_isActif(*this._panel)
  With *this
    ProcedureReturn \actif
  EndWith
EndProcedure

Procedure.b PAN_getData(*this._panel)
  With *this
    ProcedureReturn \myData
  EndWith
EndProcedure
;}
;-* SETTER METHODS
Procedure PAN_setTitle(*this._panel,title.s)
  With *this
     \title = title
  EndWith
EndProcedure

Procedure PAN_setActif(*this._panel,state.b)
  With *this
     \actif = state
  EndWith
EndProcedure

Procedure PAN_setData(*this._panel,*data)
  With *this
    \myData = *data
  EndWith
EndProcedure
;}
;-* PUBLIC METHODS
Procedure PAN_setCallback(*this._panel,*callback)
  With *this
    \callback = *callback
  EndWith
EndProcedure

Procedure PAN_addContent(*this._panel,*content)
  With *this
    AddElement(\myContents())
    \myContents() = *content
    ProcedureReturn *content
  EndWith
EndProcedure
;}
;-* CONSTRUCTOR
Procedure newPanel(title.s,actif.b = #False)
  Protected *this._panel = AllocateStructure(_panel)
  With *this
    \methods = ?S_panel
    \title = title
    \actif = actif
    \make = @_PAN_make()
    \_event = @_PAN_event()
    ProcedureReturn *this
  EndWith
EndProcedure
;}

DataSection
  S_panel:
  ; GETTERS
  Data.i @PAN_getTitle()
  Data.i @PAN_isActif()
  Data.i @PAN_getData()
  ; SETTER
  Data.i @PAN_setTitle()
  Data.i @PAN_setActif()
  Data.i @PAN_setData()
  ; PUBLIC
  Data.i @PAN_setCallback()
  Data.i @PAN_addContent() 
  E_panel:
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 75
; FirstLine = 12
; Folding = Q+Pnn
; EnableXP