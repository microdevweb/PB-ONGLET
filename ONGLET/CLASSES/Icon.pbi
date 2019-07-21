; **************************************************************************
; AUTHOR           : MicrodevWeb
; MODULE           : PB onglet
; CLASS            : Icon 
; FILE             : Icon.pbi
; VERSION          : 1.0
; DESIGNED WITH    : PureBasic 5.71 beta 2
; LICENCE          : creative commons CC BY-NC-SA
; **************************************************************************
;-* PRIVATE METHODS
Procedure ICON_hoverMe(*this._icon,mx,my)
  With *this
    If mx >= \myPos\x And mx <= \myPos\x + \myPos\w
      If my >= \myPos\y And my <= \myPos\y + \myPos\h
        ProcedureReturn #True
      EndIf
    EndIf
    ProcedureReturn #False
  EndWith
EndProcedure

Procedure ICON_drawHovered(*this._icon,*onglet._onglet)
  With *this
    StartVectorDrawing(CanvasVectorOutput(*onglet\canvasId))
    MovePathCursor(\myPos\x,\myPos\y)
    DrawVectorImage(ImageID(\imageBrig),255,\myPos\w,\myPos\h)
    StopVectorDrawing()
  EndWith
EndProcedure
;}
;-* PROTECTED METHODS
Procedure ICON_make(*this._icon,*onglet._onglet,*parent._panel,x,y)
  With *this
    MovePathCursor(x,y)
    If Not \disable
      DrawVectorImage(ImageID(\image),255,*onglet\iconSize,*onglet\iconSize)
    Else
      DrawVectorImage(ImageID(\imageGrey),255,*onglet\iconSize,*onglet\iconSize)
    EndIf
    \myPos\x = x
    \myPos\y = y
    \myPos\w = *onglet\iconSize
    \myPos\h = *onglet\iconSize
  EndWith
EndProcedure

Procedure ICON_event(*this._icon,*parent._onglet,mx,my)
  With *this
    Select EventType()
      Case #PB_EventType_MouseMove
        If ICON_hoverMe(*this,mx,my) And Not \disable
          ICON_drawHovered(*this,*parent)
          SetGadgetAttribute(*parent\canvasId,#PB_Canvas_Cursor,#PB_Cursor_Hand)
          ProcedureReturn #True
        EndIf 
      Case #PB_EventType_LeftClick
        If ICON_hoverMe(*this,mx,my) And Not \disable
          If \callback
            If \callback(*this)
              Define *o.ONGLET::Onglet = *parent
              *o\build()
            EndIf
          EndIf
          ProcedureReturn #True
        EndIf 
    EndSelect
  EndWith
EndProcedure
;}
;-* GETTERS METHODS
Procedure ICON_isDisable(*this._icon)
  With *this
    ProcedureReturn \disable
  EndWith
EndProcedure
;}
;-* SETTERS METHODS
Procedure ICON_setDisable(*this._icon,state.b)
  With *this
     \disable = state
  EndWith
EndProcedure
;}
;-* PUBLIC METHODS

;}
;-* CONSTRUCTOR
Procedure newIcon(image)
  Protected *this._icon = AllocateStructure(_icon)
  With *this
    CONT_super(*this,?S_icon,?E_icon)
    \image = image
    ; create a grey image
    \imageGrey = CopyImage(\image,#PB_Any)
    \imageBrig = CopyImage(\image,#PB_Any)
    ImageGrayout(\imageGrey)
    ImageBrigness(\imageBrig)
    \make = @ICON_make()
    \_post_event = @ICON_event()
    ProcedureReturn *this
  EndWith
EndProcedure
;}

DataSection
  S_icon:
  ; GETTERS
  Data.i @ICON_isDisable()
  ; SETTERS
  Data.i @ICON_setDisable()
  ; PUBLIC
  E_icon:
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 59
; FirstLine = 55
; Folding = --J-
; EnableXP