; **************************************************************************
; AUTHOR           : MicrodevWeb
; MODULE           : PB onglet
; VERSION          : 1.0
; DESIGNED WITH    : PureBasic 5.71 beta 2
; LICENCE          : creative commons CC BY-NC-SA
; EXAMPLE          : EX_01.pb
; **************************************************************************
XIncludeFile "../ONGLET/PB onglet.pbi"
; load some images
Enumeration 
  #IMG_NEW
  #IMG_OPEN
  #IMG_CLOSE
  #IMG_SAVE
  #IMG_SELECT
  #IMG_DRAW
  #IMG_ERAZE
  #IMG_FONT
  #IMG_COLOR
  #IMG_PARA
EndEnumeration
LoadImage(#IMG_NEW,"IMG/add.png")
LoadImage(#IMG_OPEN,"IMG/open.png")
LoadImage(#IMG_CLOSE,"IMG/close.png")
LoadImage(#IMG_SAVE,"IMG/save.png")
LoadImage(#IMG_SELECT,"IMG/select.png")
LoadImage(#IMG_DRAW,"IMG/draw.png")
LoadImage(#IMG_ERAZE,"IMG/eraze.png")
LoadImage(#IMG_FONT,"IMG/font.png")
LoadImage(#IMG_COLOR,"IMG/colors.png")
LoadImage(#IMG_PARA,"IMG/para.png")

#MAIN_FORM = 0
#CONTAINER = 0
; create onglet
; -> create linear gradient of color
;   -> non active color
Define lc.ONGLET::LinearColors = ONGLET::newLinear()
lc\addColor($FF4A4A4A,0)
lc\addColor($FF828282,0.6)
lc\addColor($FF828282,0.9)
lc\addColor($FFA9A9A9,1)
;   -> active color
Define la.ONGLET::LinearColors = ONGLET::newLinear()
la\addColor($FF006AA3,0)
la\addColor($FF00A5FF,0.6)
la\addColor($FF00A5FF,0.9)
la\addColor($FF30B6FF,1)
Global myOnglet.ONGLET::Onglet = ONGLET::newOnglet(#CONTAINER,$FF949494,$FF5C5C5C,$FFFFFFFF,$FFFFFFFF,lc,la)

Procedure evPanel(panel.ONGLET::Panel)
  Debug panel\getTitle()+" data : "+Str(panel\getData())
EndProcedure

Procedure evIcon(icon.ONGLET::Icon)
  Debug icon\getData()
EndProcedure

Define p.ONGLET::Panel = myOnglet\addPanel(ONGLET::newPanel("Project",#True))
; add bind callback and set data
p\setCallback(@evPanel())
p\setData(1)
; add icon
Define i.ONGLET::Icon = p\addContent(ONGLET::newIcon(#IMG_NEW))
;   add bind callback and set data
i\setData(11)
i\setCallback(@evIcon())
Define i.ONGLET::Icon = p\addContent(ONGLET::newIcon(#IMG_CLOSE))
;   add bind callback and set data
i\setData(12)
i\setCallback(@evIcon())
Define i.ONGLET::Icon = p\addContent(ONGLET::newIcon(#IMG_OPEN))
;   add bind callback and set data
i\setData(13)
i\setCallback(@evIcon())
Define i.ONGLET::Icon = p\addContent(ONGLET::newIcon(#IMG_SAVE))
;   add bind callback and set data
i\setData(14)
i\setCallback(@evIcon())

Define p.ONGLET::Panel = myOnglet\addPanel(ONGLET::newPanel("Tools"))
; add bind callback and set data
p\setCallback(@evPanel())
p\setData(2)
; add icon
Define i.ONGLET::Icon = p\addContent(ONGLET::newIcon(#IMG_SELECT))
;   add bind callback and set data
i\setData(21)
i\setCallback(@evIcon())
Define i.ONGLET::Icon = p\addContent(ONGLET::newIcon(#IMG_DRAW))
;   add bind callback and set data
i\setData(22)
i\setCallback(@evIcon())
Define i.ONGLET::Icon = p\addContent(ONGLET::newIcon(#IMG_ERAZE))
;   add bind callback and set data
i\setData(23)
i\setCallback(@evIcon())


Define p.ONGLET::Panel = myOnglet\addPanel(ONGLET::newPanel("Options"))
; add bind callback and set data
p\setCallback(@evPanel())
p\setData(3)
Define i.ONGLET::Icon = p\addContent(ONGLET::newIcon(#IMG_FONT))
;   add bind callback and set data
i\setData(31)
i\setCallback(@evIcon())
Define i.ONGLET::Icon = p\addContent(ONGLET::newIcon(#IMG_COLOR))
;   add bind callback and set data
i\setData(32)
i\setCallback(@evIcon())


Define p.ONGLET::Panel = myOnglet\addPanel(ONGLET::newPanel("Parameters"))
; add bind callback and set data
p\setCallback(@evPanel())
p\setData(4)
Define i.ONGLET::Icon = p\addContent(ONGLET::newIcon(#IMG_PARA))
;   add bind callback and set data
i\setData(41)
i\setCallback(@evIcon())

; open simple window
OpenWindow(#MAIN_FORM,0,0,800,600,"EXAMPLE 01",#PB_Window_SystemMenu|#PB_Window_ScreenCentered)
ContainerGadget(#CONTAINER,0,0,800,80)
CloseGadgetList()
myOnglet\build()

Repeat
  WaitWindowEvent()
Until Event() = #PB_Event_CloseWindow

; IDE Options = PureBasic 5.70 LTS (Windows - x86)
; CursorPosition = 120
; FirstLine = 97
; Folding = -
; EnableXP