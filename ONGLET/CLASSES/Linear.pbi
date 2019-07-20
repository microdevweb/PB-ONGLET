; **************************************************************************
; AUTHOR           : MicrodevWeb
; MODULE           : PB onglet
; CLASS            : Linear
; FILE             : Linear.pbi
; VERSION          : 1.0
; DESIGNED WITH    : PureBasic 5.71 beta 2
; LICENCE          : creative commons CC BY-NC-SA
; **************************************************************************
;-* PRIVATE METHODS

;}
;-* PROTECTED METHODS
Procedure _LIN_make(*this._Linear,x = 0,y = 0,w = 0,h = 0)
  With *this
    If Not \horizontal
      VectorSourceLinearGradient(x,y,x,y + h)
      ForEach \myColors()
        VectorSourceGradientColor(\myColors()\color,\myColors()\position)
      Next
    EndIf
  EndWith
EndProcedure
;}
;-* GETTERS METHODS

;}
;-* SETTER METHODS

;}
;-* PUBLIC METHODS
Procedure LIN_free(*this._Linear)
  With *this
    FreeStructure(*this)
  EndWith
EndProcedure

Procedure LIN_addColor(*this._Linear,color,position.f)
  With *this
    AddElement(\myColors())
    \myColors()\color = color
    \myColors()\position = position
  EndWith
EndProcedure
;}
;-* CONSTRUCTOR
Procedure newLinear(horiszontal.b = #False)
  Protected *this._Linear = AllocateStructure(_Linear)
  With *this
    \methods = ?S_Linear
    \_make = @_LIN_make()
    \horizontal = horiszontal
    ProcedureReturn *this
  EndWith
EndProcedure
;}

DataSection
  S_Linear:
  ; PUBLIC
  Data.i @LIN_free()
  Data.i @LIN_addColor()
  E_Linear:
EndDataSection
; IDE Options = PureBasic 5.70 LTS (Windows - x86)
; CursorPosition = 19
; FirstLine = 7
; Folding = --
; EnableXP