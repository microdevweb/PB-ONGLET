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

;}
;-* PROTECTED METHODS

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
;}
;-* PUBLIC METHODS
Procedure CONT_super(*this._content,*s_daughter,*E_daughter)
  With *this
    ; allocate memory
    Protected motherLen = ?E_content - ?S_content,daughterLen = *E_daughter - *s_daughter
    \methods = AllocateMemory(motherLen + daughterLen)
    ; empilate methods address
    MoveMemory(?S_content,\methods,motherLen)
    MoveMemory(*s_daughter,\methods + motherLen,daughterLen)
    ; set values
    
  EndWith
EndProcedure
;}
;-* CONSTRUCTOR

;}

DataSection
    S_content:
    ; GETTERS
    Data.i @CONT_getData()
    ; SETTERS
    Data.i @CONT_setData()
    Data.i @CONT_setCallback()
    E_content:
EndDataSection
; IDE Options = PureBasic 5.70 LTS (Windows - x86)
; CursorPosition = 60
; FirstLine = 3
; Folding = Qw
; EnableXP