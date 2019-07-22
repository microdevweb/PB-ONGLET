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

Procedure AddPathFullRoundBox(x.d,y.d,w.d,h.d,radius.d,flags=#PB_Path_Default)
   MovePathCursor(x+radius,y,flags)
   AddPathArc(w-radius,0,w-radius,radius,radius,#PB_Path_Relative)
   AddPathArc(0,h-radius,-radius,h-radius,radius,#PB_Path_Relative)
   AddPathArc(-w+radius,0,-w+radius,-radius,radius,#PB_Path_Relative)
   AddPathArc(0,-h+radius,radius,-h+radius,radius,#PB_Path_Relative)
   ClosePath()
   MovePathCursor(-radius,0,#PB_Path_Relative)
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
Prototype _showHelp(*para)
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
  shortCut.i
  idMenu.i
  _make._makeContent
  helpText.s
  disable.b
EndStructure
Structure _icon Extends _content
  image.i
  imageGrey.i
  imageBrig.i
  hovered.i
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
  idForm.i
  lastEvent.i
  idHelpForm.i
  idHelpCanvas.i
  helpIcon.i
  helpFont.i
  helpMaskColor.q
  helpBackColor.q
  helpFrontColor.q
  helpIconSize.i
  helpIconDecalageV.i
  helpIconDecalageH.i
  helpMargin.i
  Map *myEventMenu()
EndStructure
Structure _show
  *onglet._onglet
  on.b
  text.s
  x.i
  y.i
  idThread.i
EndStructure
Global *gCurrentOnglet._onglet
Global gParaShow._show
Procedure _showHelp(value)
  With gParaShow
    Repeat
      ; calculate text size
      If \on
        StartVectorDrawing(CanvasVectorOutput(\onglet\idHelpCanvas))
        VectorFont(FontID(\onglet\helpFont))
        Protected wt = VectorTextWidth(\text)
        Protected ht = VectorTextHeight(\text)
        StopVectorDrawing()
        ; calcultate size
        Protected w = wt + \onglet\helpMargin * 3
        Protected h = \onglet\helpIconSize + ht + \onglet\helpMargin * 2
        Protected xf = WindowX(\onglet\idForm) + GadgetX(\onglet\canvasId) + \x
        Protected yf = WindowY(\onglet\idForm) + GadgetY(\onglet\canvasId) + \y
        ResizeWindow(\onglet\idHelpForm,xf,yf,w,h)
        ResizeGadget(\onglet\idHelpCanvas,0,0,w,h)
        StartVectorDrawing(CanvasVectorOutput(\onglet\idHelpCanvas))
        VectorSourceColor($FF000000)
        FillVectorOutput()
        AddPathFullRoundBox(0,\onglet\helpIconDecalageV,w - \onglet\helpIconDecalageH,h - \onglet\helpIconDecalageV,12)
        VectorSourceColor(\onglet\helpBackColor)
        FillPath()
        MovePathCursor(\onglet\helpMargin ,\onglet\helpMargin * 2 + \onglet\helpIconDecalageV)
        VectorSourceColor(\onglet\helpFrontColor)
        VectorFont(FontID(\onglet\helpFont))
        DrawVectorText(\text)
        MovePathCursor(w - \onglet\helpIconSize,0)
        DrawVectorImage(ImageID(\onglet\helpIcon),255,\onglet\helpIconSize,\onglet\helpIconSize)
        StopVectorDrawing()
        SetWindowLong_(WindowID(\onglet\idHelpForm), #GWL_EXSTYLE, #WS_EX_LAYERED | #WS_EX_TOPMOST)
        SetLayeredWindowAttributes_(WindowID(\onglet\idHelpForm),$FF000000,0,#LWA_COLORKEY)
        HideWindow(\onglet\idHelpForm,#False)
        SetActiveWindow(\onglet\idForm)
      Else
        HideWindow(\onglet\idHelpForm,#True)
      EndIf
      Delay(1)
    ForEver
  EndWith
EndProcedure

Global gThread 



; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 215
; FirstLine = 120
; Folding = mj0-
; EnableXP