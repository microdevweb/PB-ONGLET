; **************************************************************************
; AUTHOR           : MicrodevWeb
; MODULE           : PB onglet
; CLASS            : Content ABSTRACT
; FILE             : Content.pbi
; VERSION          : 1.0
; DESIGNED WITH    : PureBasic 5.71 beta 2
; LICENCE          : creative commons CC BY-NC-SA
; **************************************************************************
;-* PRIVATE METHODS
Procedure _CONT_event()
  If *gCurrentOnglet
    If FindMapElement(*gCurrentOnglet\myEventMenu(),Str(EventMenu()))
      Protected *this._content = *gCurrentOnglet\myEventMenu()
      If *this
        With *this
          If \callback
            If \callback(*this)
              Define *o.ONGLET::Onglet = *gCurrentOnglet
              *o\build()
            EndIf
          EndIf
        EndWith
      EndIf
    EndIf
  EndIf
EndProcedure
;}
;-* PROTECTED METHODS
Procedure _CONT_make(*this._content,*onglet._onglet,*parent._panel,x,y)
  With *this
;     Debug \shortCut
;     Debug \idMenu
;     If \shortCut : CallDebugger:EndIf
    If \shortCut And Not \idMenu
      \idMenu = *onglet\lastEvent
      *onglet\lastEvent - 1
      AddMapElement(*onglet\myEventMenu(),Str(\idMenu))
      *onglet\myEventMenu() = *this
      FindMapElement(*gCurrentOnglet\myEventMenu(),Str(\idMenu))
      AddKeyboardShortcut(*onglet\idForm,\shortCut,\idMenu)
      BindEvent(#PB_Event_Menu,@_CONT_event(),*onglet\idForm,\idMenu)
    EndIf
  EndWith
EndProcedure
;}
;-* GETTERS METHODS
Procedure CONT_getData(*this._content)
  With *this 
    ProcedureReturn \myData
  EndWith
EndProcedure
;}
;-* SETTERS METHODS
Procedure CONT_setData(*this._content,*data)
  With *this 
     \myData = *data
  EndWith
EndProcedure

Procedure CONT_setCallback(*this._content,*callback)
  With *this 
     \callback = *callback
  EndWith
EndProcedure

Procedure CONT_setHelpText(*this._content,text.s)
  With *this 
     \helpText = text
  EndWith
EndProcedure
;}
;-* PUBLIC METHODS
Procedure CONT_setShorcut(*this._content,shortCut)
  With *this 
    \shortCut = shortCut
  EndWith
EndProcedure
;}
;-* CONSTRUCTOR
Procedure CONT_super(*this._content,*s_daughter,*E_daughter)
  With *this
    ; allocate memory
    Protected motherLen = ?E_content - ?S_content,daughterLen = *E_daughter - *s_daughter
    \methods = AllocateMemory(motherLen + daughterLen)
    ; empilate methods address
    MoveMemory(?S_content,\methods,motherLen)
    MoveMemory(*s_daughter,\methods + motherLen,daughterLen)
    ; set values
    \_make = @_CONT_make()
  EndWith
EndProcedure
;}

DataSection
    S_content:
    ; GETTERS
    Data.i @CONT_getData()
    ; SETTERS
    Data.i @CONT_setData()
    Data.i @CONT_setCallback()
    Data.i @CONT_setHelpText()
    ; PUBLIC
    Data.i @CONT_setShorcut()
    E_content:
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 101
; FirstLine = 41
; Folding = 080-
; EnableXP