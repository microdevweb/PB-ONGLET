; **************************************************************************
; AUTHOR           : MicrodevWeb
; MODULE           : PB onglet
; CLASS            : Structure
; FILE             : Structure.pbi
; VERSION          : 1.0
; DESIGNED WITH    : PureBasic 5.71 beta 2
; LICENCE          : creative commons CC BY-NC-SA
; **************************************************************************

Procedure AddPathRoundBox(x.d,y.d,w.d,h.d,radius.d,close.b = #True)
   MovePathCursor(x,y + h)
   AddPathLine(0,- h + radius,#PB_Path_Relative)
   AddPathArc(0,-radius,radius,-radius,radius,#PB_Path_Relative)
   AddPathArc(w-radius,0,w-radius,radius,radius,#PB_Path_Relative)
   AddPathLine(0, h - radius,#PB_Path_Relative)
   If close
     ClosePath()
   EndIf
EndProcedure

Procedure ImageGrayout(image)
  Protected w, h, x, y, r, g, b, gray, color
  
  w = ImageWidth(image)
  h = ImageHeight(image)
  StartDrawing(ImageOutput(image))
  For x = 0 To w - 1
    For y = 0 To h - 1
      color = Point(x, y)
      r    = Red(color)
      g    = Green(color)
      b    = Blue(color)
      gray = 0.2126*r + 0.7152*g + 0.0722*b
      Plot(x, y, RGB(gray, gray, gray))
    Next
  Next
  StopDrawing()
EndProcedure

Procedure ImageBrigness(image)
  Protected w, h, x, y, r, g, b, br,bb,bg, color,nivel = 40
   w = ImageWidth(image)
  h = ImageHeight(image)
  StartDrawing(ImageOutput(image))
  For x = 0 To w - 1
    For y = 0 To h - 1
      color = Point(x, y)
      r    = Red(color)
      g    = Green(color)
      b    = Blue(color)
      If r + nivel <=255
        r = r + nivel
      Else
        r = 255
      EndIf
      If g + nivel <=255
        g = g + nivel
      Else
        g = 255
      EndIf
      If b + nivel <=255
        b = b + nivel
      Else
        b = 255
      EndIf
      Plot(x, y, RGB(r, g, b))
    Next
  Next
  StopDrawing()
EndProcedure
 

Prototype _makeLinear(*this,x = 0,y = 0,w = 0,h = 0)
Prototype _makePanel(*this,*parent,x,y = 0)
Prototype _makeContent(*this,*onglet,*parent,x,y)
Prototype _panelEvent(*this,*parent,mx,my)
Prototype _disableAllPanel(*this)
Prototype _panelCallback(*this)
Prototype _drawInnerBox(*this)
Structure _pos
  x.i
  y.i
  w.i
  h.i
EndStructure
Structure _color
  color.i
  position.f
EndStructure
Structure _Linear
  *methods
  List myColors._color()
  _make._makeLinear
  horizontal.b
EndStructure
Structure _content
  *methods
  myPos._pos
  myData.i
  callback._panelCallback
  make._makeContent
  _post_event._panelEvent
EndStructure
Structure _icon Extends _content
  image.i
  imageGrey.i
  imageBrig.i
  hovered.i
  disable.b
EndStructure
Structure _panel
  *methods
  title.s
  actif.b
  make._makePanel
  _event._panelEvent
  myPos._pos
  myData.i
  callback._panelCallback
  List *myContents._content()
EndStructure
Structure _onglet
  *methods
  containerId.i
  canvasId.i
  imageId.i
  panelFont.i
  innerBackColor.i
  innerFrontColor.i
  backGroundColor.i
  panelTitleColor.i
  iconSize.i
  *myColor._Linear
  *myActiveColor._Linear
  List *myPanels._panel()
  _disableAllPanel._disableAllPanel
  _drawInnerBox._drawInnerBox
EndStructure


; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 108
; FirstLine = 89
; Folding = ---
; EnableXP