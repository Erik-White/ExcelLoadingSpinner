VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frmLoading 
   Caption         =   "Loading..."
   ClientHeight    =   4575
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   8040
   OleObjectBlob   =   "frmLoading.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "frmLoading"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim pAllowClose As Boolean

Public Sub initForm(Optional allowClose As Boolean = False, Optional captionHeading As String = "LOADING, PLEASE WAIT", Optional captionDescription As String = "IMPORTING DATA FROM EXTERNAL FILES")
'Build and show the form for an animated loading gif
'By default the form cannot be closed by the user and will only be closed programmatically when the task is finished
'The title and description text can be changed if required with captionHeading and captionDescription

    'On Error GoTo errHandler
    Dim htmlStr As String
    Dim imgStr As String
    
    pAllowClose = allowClose
    
    imgStr = loadingImage
    If Not imgStr Like "data:image/*" Then GoTo errHandler

    'Set the text in the form
    textHeading.Caption = UCase(captionHeading)
    textDesc.Caption = UCase(captionDescription)
    
    'Define the HTML for the web control object
    htmlStr = "<HTML><BODY style='border-style:none;'><div style='align:center'><img alt='' src='" & imgStr & "' /></div></BODY></HTML>"
    
    'Load the web control object to display the image
    With Me.loadingBrowser
        .Navigate "About:blank"
        .Document.write htmlStr
        .Document.body.Scroll = "no"
    End With
    
    Me.Show vbModeless
    
    'Workaround for window activation/focus issue
    With Application
        .ShowWindowsInTaskbar = False
        .ShowWindowsInTaskbar = True
    End With
    
    Exit Sub
    
errHandler:

End Sub

Private Sub UserForm_QueryClose(Cancel As Integer, CloseMode As Integer)
'Prevent the window from being closed before loading is completed
     
    If CloseMode = vbFormControlMenu And Not pAllowClose Then
    
        Cancel = True
        MsgBox "Please wait for the data to finish loading", vbCritical, "Loading"
        
    End If
     
End Sub

Private Function loadingImage() As String
'Returns a string with the base64 encoded loading image

    Dim imgStr As String

    imgStr = imgStr & "data:image/gif;base64,R0lGODlhgACAAKUAAAQCBISChERCRMTCxCQiJGRiZOTi5KSmpBQSFJSSlFRSVNTS1DQyNHRydPTy9LS2tAwKDIyKjExKTMzKzCwqLGxqbOzq7KyurBwaHJyanFxaXNza3Dw6PHx6fPz6/Ly+vAQGBISGhERGRMTGxCQmJGRmZOTm5KyqrBQWFJSWlFRWVNTW1DQ2NHR2dPT29Ly6vAwODIyOjExOTMzOzCwuLGxub"
    imgStr = imgStr & "Ozu7LSytBweHJyenFxeXNze3Dw+PHx+fPz+/P///yH/C05FVFNDQVBFMi4wAwEAAAAh+QQICAAAACwAAAAAgACAAAAG/sCfcEgsGo/IpLLo6HEAAFbAsaxar9isdjsc4KBgAG7ALZvP6OolzAZc0vC43GqDtMMQ23zPl3fubB19g4RbNIBhNIWLjEkgiGAwjZOUMJBQEJSaShMaXxgyD1sMlwCKm6hDPg13ClRYLaWCqak1iBJZFnaIEBa0qA+X"
    imgStr = imgStr & "KVknkAdnJr9cEpckWi9fbDiiZQcoYjPKWD6Pl8lZTSxQLD2vXCbdAAjm2koOpQALymthI+1VLvA7ygts3/dKxEFC0M4WlGEAl6S41OLeggwrElbxwAMRCXYSMx4xQaoNiQ0aQyZxEeIaFBgtMIpcSWTFBHksY8qcSbOmzZs4c+rcybOn/s8zDnLIYMCgQbafymZEC1PDA9JUGyzdKfEUlUBAb6pa2RCixAGnXCZcwqV1yQoMYET44BLiUqaySlS"
    imgStr = imgStr & "wecEl1iUXcJNQYINQS4xLKPIm0cDG3pYVlzQIRmKCABjFZQRAMrzYiI0UXpEhANSj8qIdHcGAiOG50YMSIgqE8FW6tevXsGPLnk27tu3buHPr3s27t+/fwIPH9JCiI44OrIUrsVGRDYqjypEUAEQCrO8dKjCQqIHxBaRZvXdIhcIA7xAdkHD8lsuG9JCrgMzzNhlGBpEnkNb2RssGspASkFDwG4BsnEBEP4gk8JsNh4BBVRGs3MGCfL0Rp0EJd"
    imgStr = imgStr & "BnhQYRh/vCgR3RKzNAADQyoQA2IKKao4oostujiizDGKOOMNNZo44040rLDDBNYB+ME+KnTAYUsXpAOGCz42JoLMbBQInRbmDAeGw3A5oJkomW1RQ+8fNhaW2zkwUVzgHzw2l5tHDMKJAa6tlkb7mkhAyRQeoblXFzkgAgOSlYWDBtJcuECfGHcEFsM6dCwTxkcsQFCX7CZkEIEWprhQgI8EEBDCSDl6OmnoIYq6qiklqqcSi/uoEM3MtSpjAc3"
    imgStr = imgStr & "ZJBhTRNMCQAIlf4ywZtikDGTA0uFAYMB2tQaZkQyLcSZNmSG4R9LBN4hwquAYDATeoDwoIwNgBAkUwCIPPiLY20IMBM6YYC4uomybJwYE7thNFTGBiUQxekZBoER50wH8AqDgmXkcCQIOZwxQg0lpEDsTR58kMIARGYxQ7ovEnbHsyuS2wYBL5IACMcuWtyGCi+OAAhlLaYwMKQu0kvDpp2aKrMmQQAAIfkECAgAAAAsAAAAAIAAgACFBAIEhIK"
    imgStr = imgStr & "EREJExMLEJCIkpKKkZGJk5OLkFBIUlJKUVFJUNDI0tLK0dHJ09PL01NLUDAoMjIqMTEpMzMrMLCosrKqsbGps7OrsHBocnJqcXFpcPDo8vLq8fHp8/Pr83NrcBAYEhIaEREZExMbEJCYkpKakZGZk5ObkFBYUlJaUVFZUNDY0tLa0dHZ09Pb0DA4MjI6MTE5MzM7MLC4srK6sbG5s7O7sHB4cnJ6cXF5cPD48vL68fH58/P783N7c////Bv7An3"
    imgStr = imgStr & "BILBqPyKTSeCnVTLjDckqtWq/YbDEDAXgBoJBHSy6bz9Ne7MsGrBzouHxe7bTbGrp+T7eB7m0PfIOEWTiAbR2Fi4xJdohfCo2TlA2QkVouMiMyY5RyMhEmAQxaKZdeilcXJghfLxYnn2YnOm03A1g+qAAjVyMYgBi+s1kHKIgsWCaXOlfHkAg+xVgbkC+yVg4ziDdSVmuXEtRWA6gBWC6WbSpwVru80+RTLagrWg8pBhowMoa8ADLMm6IB1Q1q"
    imgStr = imgStr & "AQCiG6iE2SUK1GAAjMBQyaFLOaiZ47WjYhIHLy7lKtbjhsEeHpMwgJSR3MpLNFIqyfCnjQlP5NYBaiFzyf4HE9xuxOhYMYUrNi9K9FxqxUUFE1AruGBKtarVq1izat3KtavXr2DDxukxIAWOD2KX4gj2ZQPatBV5AILgD+48DpBuTLWbxcaEM7YgFeCLJYIXBHWzeEDVkjCVjV5uoMwCD5IIx1UkssmGZfGlPJin4P2CYnIWAZdShKYiF4wyMiz"
    imgStr = imgStr & "yulu95MSIvWXq3aFL+xOOo15WvO1NyQWLFCmGE1/OvLnz59CjS59Ovbr169iza9/Ovbv37+DJuaDRwUIGzuGrTCDBBgSM9FU+1GzDA74QB7OLrEAEQlD4Wl7EcEERD1xiQXqBBVjERYgIEF5lXww4RAGXOAgehF7YQESBkP7wFB5qX6hghASIQCAPeCeQCIACGhZxQEh3qGafC7gZ8QA3r8hoHxUyZBACBxLuKOSQRBZp5JFIJqnkkkw26eSTUE"
    imgStr = imgStr & "Yp5ZTEcRDDAgvUoFySPRjQBgQxUedACRlwcMYjbfQ3HTBttZjFBfO1EYN0DgDnBWhZlHCNdBkAkp8Vp0BSY3OtBaJFbIggIF0Fd4AwaBUu2MlGDdK5QAF9ZTDIBgpBQneCCF6A0IJppsRJgn/UadJpGRekYIIFNJBK5ay01mrrrbjmquuu4TlQQAoFuMlkCjCCUYFMCVxKAQw4ZaVpqGEyVBAbkmgVKSAvPDoLom1EexW3d3hLjUN4aPUsG3o6k"
    imgStr = imgStr & "pMDINViBdkdZg5k2B0haFUSIKUxdAEymwp71WhtvKZFDwWYkEMKf2LxAHtenNrVAAwDQABRWhyw3xc3JEYGBzic6NUDHGisxcVsYJBwke+iu6Rmd5iwZJ+ANLAkhl8InKROX1i4pAcBzFfDyUjawAED6PFqNCVBAAAh+QQICAAAACwAAAAAgACAAIUEAgSEgoTEwsREQkSkoqTk4uRkYmQkIiQUEhSUkpTU0tRUUlS0srT08vR0cnQ0MjQMCgy"
    imgStr = imgStr & "MiozMysxMSkysqqzs6uxsamwsKiwcGhycmpzc2txcWly8urz8+vx8enw8PjwEBgSEhoTExsRERkSkpqTk5uRkZmQkJiQUFhSUlpTU1tRUVlS0trT09vR0dnQ0NjQMDgyMjozMzsxMTkysrqzs7uxsbmwsLiwcHhycnpzc3txcXly8vrz8/vx8fnz///8G/sCfcEgsGo/IpBKpUSyf0Kh0Sq0eGyYYAABaFazgsHgcFeC2aACMRm6739KCNo0Gie"
    imgStr = imgStr & "D4PH5Dp7/0gIFWLRB9dDqCiYpJGoZ0bIuRkQqOaRSSmE81EiVgNZVoMlUqNg8nDyZOmWIsL2g4MR1VI6A4VQGGHj2rViGGAy1UIqAkVA6VFrxUNMhVOSCGDlQcoAAcylIXoJ1UCtqvLFUf1SPYUI2gCWAqKSl3VS3VW8HmStSgNrwF8gCI9UnDQLngVYFfjX9JGkCrxEDZGVAoECoxUenALl64QPmQmPCEIRASsDXw6OjAQY5ISgygg0OUOQUoD"
    imgStr = imgStr & "KFQgXKJCBcmLNC4WK+C/olCW0DsqFCzaJQaMlJIaGC0qdOnUKNKnUq1qtWrWLNy1JAhBQ2iWjnSeEBnBTcrDTxg2PKhWFgrGfugCFlFB8k0O3i+hUKhFlgpHW44CrA3SgME1fJNIVEJBr3CShhXczxlBahwkCfyEzBlXKUMmZXwkddQygJQkEIfoSiPx5QUlUCcVG0khzwQTKWMdLSR9hWglTZUgdlnhizfR2xXQnB2Sokdc06kQK7EhiMYrsVU"
    imgStr = imgStr & "OE498kM0I/x1X8QghY8UGsarX8++vfv38OPLn0+/vv37+PPr38/fvQYZ3PU3RQc+zAHADOkJGEUPE/SBAE0KPgGbIX9ESMAIM6RGxDeG/tDVHwFpXENEB6CAJqBnWwg3YokK0oKGihtWokp/km0hIhHK9fFBhD/kMMMCpRkxWhooiMejEgQ8BMEOuR0JRQUQOinllFRWaeWVWGap5ZZcdunll2CGKeaYVimQA4BeinAXAm5pKcFCaZgInw4hmJ"
    imgStr = imgStr & "BDgFUI1gcEs7WngoEr6DUFOoYQAN8Oj4BxjyEhwEdWGhGAIUMlhr6HaIhhHPDRF++VwKEJYohgIBqNxldBCg5oCIYEMW0BQaRddkBDCiT0SeatuOaq66689urrr/ZpwINLXRaw0hY43PhPBTGYEMFfUtXwHRrZ1SNDqwAg8I5UHhhywz89aJoGDoI6xSEdc5xiExAdyj41bRpRKsOCIZdINYMhMOC5SgmGGPnUomkM9I8LdIBKVQR0GCdGCyLw0"
    imgStr = imgStr & "GQYISAGQwj6QqVAAAOs0CYYOSDGBcVcMkOHB1yKm4ZsWvJrSLVXNuCIh1geO265VWoAnI1d6jADBCB8sC2wQAfdRhAAIfkECAgAAAAsAAAAAIAAgACGBAIEhIKEREJExMLEJCIkpKKkZGJk5OLkFBIUlJKUVFJU1NLUNDI0tLK0dHJ09PL0DAoMjIqMTEpMzMrMLCosrKqsbGps7OrsHBocnJqcXFpc3NrcPDo8vLq8fHp8/Pr8BAYEhIaEREZE"
    imgStr = imgStr & "xMbEJCYkpKakZGZk5ObkFBYUlJaUVFZU1NbUNDY0tLa0dHZ09Pb0DA4MjI6MTE5MzM7MLC4srK6sbG5s7O7sHB4cnJ6cXF5c3N7cPD48vL68fH58/P78////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    imgStr = imgStr & "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB/6AQIKDhIWGh4iJiouMjY6PkJGSkgsuAjwOA5ObnJ2ejz8OAKOkGi+fqKmqkBakrgAyq7KzsyOvryW0urubrbekArzCw4sUv6QwxMrLgiTHoyDM0sIyzwA0mxspCRk7054/FSoME"
    imgStr = imgStr & "jE3kznWPpInEq8yJ9+TByyvKJqRHzTHKA+RKwh+odggD9ILY7dArJBE7xaJhZD0PaPxo6CjGM8UTPoRYh8AEi5ORWpgDUAui4wYWPO36cO5TTpKakDJKOCzGfJ4lORAcxEOa96+CSgpoqciBc9QVPzmoqQDo4kGPFsnb0FJiFAPNb3FY6m8rb9cZFWUAwUpCDY+oPxh4pcJr/5jD/0YkaIHy54NRJAS0SKu37+AAwseTLiw4cOIEytezLixY2Y/"
    imgStr = imgStr & "CggAAQCDjgmeTsQwYaEG3MeOTui8RXVSCgiuSBAE7eiFymOlIaW7heIC60airOE0aPOWjduLXsAoqWPkMwTAFUktSSBSCmsikxuqURJAMkglnl2XbqhDdQyRLlD+NZO7IfElNUby8Uuh+UMaSjaQ9MPAKwh93xs6YfaYCk4dyEADAy4EpZ8hE/T3igh3HajLCSYMNwoJCTi4zAwTGGjhhhx26OGHIIYo4ogklmjiiSimqOKKLLYoywMhKIADCSq"
    imgStr = imgStr & "koJaLjQzw0ysULGDIBg7wIIIHtrVYwDMg4P4jSA7jjYJAByyegNozGLy0QJOkIBCPijZUF4Mg1fxiwYo7WsODIAq+woKKL1QHAAqC9PYKA2y6iYMg7rhFZnVnAtFCez6q2FZJEQwSwisg5MDiBljeAsNLgowgAQo4qLAaixg9UwOOiyTQKAAQnMSpIjvYsCNIkI6q6qqsturqq7DGKuustNZq66245qoriCk4A4AEWM3qCykgjCDiCTPcyEkPvx"
    imgStr = imgStr & "Dw2YYejALDbpsMeouxHv5JCgbPPpLnLRV8GMErW05i7SvYdugdKUpxMsEvJIQ4KARQdpIbKTgccOwE0XVSwD4gqKDhrgQXbPDBCCes8MIMN+ywiR2IQAMHCZB0+2qmpEhg8TQ7uMCBB+UStsMvGfR0AgGkkBCyYBi7EgxN0boSm2BguYINTTG5YoBh2d1SHE0JvFJyYS+UCU2wBb2g1yg/G7YCyqNAsClUPaSg5GEv1JBCAUVy8oALFJBgQtez"
    imgStr = imgStr & "vuDRKFXWGsAtO9M61CvN0bq0KxTUmsEtHtj67TXK0pqCAjJE0O/DhBf+SSAAIfkECAgAAAAsAAAAAIAAgACFBAIEhIKEREJExMLEJCIkZGJk5OLkpKKkFBIUVFJU1NLUNDI0dHJ09PL0tLK0lJKUDAoMTEpMzMrMLCosbGps7OrsrKqsHBocXFpc3NrcPDo8fHp8/Pr8vLq8nJqcjIqMBAYEhIaEREZExMbEJCYkZGZk5ObkpKakFBYUVFZU1Nb"
    imgStr = imgStr & "UNDY0dHZ09Pb0tLa0lJaUDA4MTE5MzM7MLC4sbG5s7O7srK6sHB4cXF5c3N7cPD48fH58/P78vL68nJ6c////Bv7An3BILBqPyKRyyWw6n9CodGqwnHLTrHbLjWYEgDBgpeqaz+ioAiEWQ0bpuFzOm7XbhNZ8z8/27ncWfYOESwGAbQyFi4xCG4hiJY2Tgy+QYR9bepRmHB0vLg1ZJiCXWFIdImIiA5xaJ2xhEDtZIZCKUiyIma5RD4g4Wbp3FD"
    imgStr = imgStr & "xSv5AnvU+kkD1ZMhQzCyVwUi0wlxfGy0y2kMGuFpdhz91LOJcLvd+XHudLFJc6vciXgvBJPpe4nH/kGfIlaXEDEYRTnHhMmCdQiYxYYkDg6yWjFCAYZRomyYHDoggF8HqguHPDmsaTSxq8SLEAg49NKGPKnEmzps2bOHPq3Mmzp/7Pn0CDamlhgUaJECC7yDhhQGgWGxDDRKigpQcBMTcmOm1iCdENqlIGIDqwtYkKi4giTCGBCAbMskjkkZMRR"
    imgStr = imgStr & "cYlG3CVXCAHIEQUG5ce5E3CFwCNKBLuDkYCga9fKBwKXhS12Igqch2kAAbko/KRzZBIcJgCVQyMzp6PYLhkbkoLFy9svE1NpMXqOzDw0h7kIsYECDNYNN1NvLjx48iTK1/OvLnz59CjS59Ovbr16xprdAjxYMBs7El4BEALAIayIzkseKB7vcECSBi4CeHxaJUJ6wnI8RLCANCE787ZRQ4ENQhhACTvTDcMOWT9cAA41OXHFy0/7IMIBtRdRg4"
    imgStr = imgStr & "LQv4oAMl+0dFQWII/xAAIAgVO50Jh9wlRg4YA3MAedSuQI0kRDrBQwkvXZRBVGzMACN4QOdR4RwKUDanEdglg8EFGSkYp5ZRUVmnllVhmqeWWXHbp5ZeTqOBBbGBp6cBCEeEw3JX1nTijFDU8UAIFmR1nISQ3JAmFAntFYhw2fB0WBQ9s3fFCcXdegoCQSawIyAzFpVPYm014gAgCxUVQGAB1PuHoHZASJylfEkRBECAgpmYpXyAwmoQE2YiRgn"
    imgStr = imgStr & "y0NdCYjVlUsEMKJehmnD2IoFAmlXJdVCqWB0gmRgxrZmnDCzu8gBCY1FZr7bXYZqvttnzw4MALJ+iZpQmFAoCASXXwqOBDQDqB0cYNrjZySBiH4pQBIg6ke0eLNo2ACInLgBYGujTVQN7A8DQTBgzi0lRsGAIIdEI2KLR2UwsMWJRCw90kxVMDEgy7RQ0cY1nBZSKIjKWmy3JZASAqV2kCzFzCGEOXFZgIQAIpdtlCvNwGLfQcQQAAIfkECAgAA"
    imgStr = imgStr & "AAsAAAAAIAAgACFBAIEhIKExMLEREJEpKKk5OLkZGJkJCIkFBIUlJKU1NLUVFJUtLK09PL0dHJ0NDI0DAoMjIqMzMrMTEpMrKqs7OrsbGpsHBocnJqc3NrcXFpcvLq8/Pr8fHp8PDo8LC4sBAYEhIaExMbEREZEpKak5ObkZGZkJCYkFBYUlJaU1NbUVFZUtLa09Pb0dHZ0NDY0DA4MjI6MzM7MTE5MrK6s7O7sbG5sHB4cnJ6c3N7cXF5cvL68"
    imgStr = imgStr & "/P78fH58PD48////Bv7An3BILBqPyKRyyWw6n9CodEqtWq/YKGsAAIx22bB47OQZumiAjcxukyPpdMpNr0t5iDj6Zu/7kyJ6aRl/hYU7gmgShox2BYldNY2TRxkyBVY+iTNUHAQmMxYslFU7H2gDKlQqEHowOVMqJ3EDFaRRNK6qUyKzaB8KUyUXgi8ct04NeXovVTwiKSmLVBqQEchNFJCElC0gkB/YTHCJo5QqkAAg4ksYkDKkj5AI7EoliT"
    imgStr = imgStr & "fHlDwokCP1SlwIooEsACQGAJPwcJAGBA5sLV4IMpFwSY4ULghIEsdBRxoIASqKbFICRwoKG0eqXMmypcuXMGPKnEmzps2bOHPqLMJBwv6lndgaOICBxoOAKwJmPHiRoAXQJyV8xXlIJUScDymfKuEiCISIKQIEadC6ZEM6TlJWJLJFFomNdACcRnmQ6GvbIxPgworCVU+wu0Y8pmsgJYagE4CPpEiHWAqHU3E2JDbSgGiiOVMa6PgG4IPkyUZYJ"
    imgStr = imgStr & "PpnpYaEXaCPbFiGxoS+1HRaULBhIsRe2Lhz697Nu7fv38CDCx9OvLjx48iTK19eR8Zt5k0yzECDwERW6EcwcE5z4y+RDCNavTianAGkC1llbO9CAjmPA+lcEJEYBwGP42HT8RHSING04obBtVEFiZAHIFwAlDDEDXqAcJ1wuaQDARHaxNEDcpWlMxYRBP4sA0II9yFHTlfcFCGDAHIpV02DFGCnRAysdWaXi0rskAIGJdKo44489ujjj0AGKeSQ"
    imgStr = imgStr & "RBZp5JFIJolEAzFABoEO//koiyDXWFGBDN7lVgExiSRAxUK/ZJmaWpCAoKAUPcRxQ4qg3QPXhVFwYFkaBOBWYToeSCFPHB3gthhcjUHhjR6YpUYCgs1I8VYaCDwImJvpODAFBwuggQI8uU2XDmpSqJACC6/hlkOMFv4oQD96uAZkCTbM6QNCROYgQahK1mrrrbjmOlkDFPRQG6hCdqimgT0KlAhVPBKQDgiYtlSCAw+4cCYp/MBFGkslsIbeLeY"
    imgStr = imgStr & "h+NxIaaYREinGwgXrSmyCoWHALSYgCACyKgWIBga3WIXgZytxoEkXA7DZiAQIOugSBywkwEKIt0AGybo8qgcJCmzpRsAIMxBEBQXrWdpsbsqigW+nmnbxZMS69QXAhlWUYKMMjuJmMspBHupxkQQMMILFuuas885sBAEAIfkECAgAAAAsAAAAAIAAgACGBAIEhIKEREJExMLEJCIkpKKkZGJk5OLkFBIUlJKUVFJU1NLUNDI0tLK0dHJ09PL0D"
    imgStr = imgStr & "AoMjIqMTEpMzMrMLCosrKqsbGps7OrsHBocnJqcXFpc3NrcPDo8vLq8fHp8/Pr8BAYEhIaEREZExMbEJCYkpKakZGZk5ObkFBYUlJaUVFZU1NbUNDY0tLa0dHZ09Pb0DA4MjI6MTE5MzM7MLC4srK6sbG5s7O7sHB4cnJ6cXF5c3N7cPD48vL68fH58/P78////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    imgStr = imgStr & "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB/6AQIKDhIWGh4iJiouMjY6PkJGSk5SVlpeYkRM6DCw2J5mhoqOPIQCnpzAtpKy"
    imgStr = imgStr & "tpC2osQigrrW2khyxsQ63vb6KMLqoHL/FxkDBwgDEx822AsoALs7UrbDCMLSTDx0pM9WWIzYmLt+VMSCxMB2UPx7ppzjs4JEOuiWWCyYMHJ+VGsoq0HuUQdkqcDWiwXgwsBEBZSzoSYgGIEfDRS+igaCHgyKvi4k+RENAjwJFHyAVQROmgJ4Oig1SJhoBDxWEFfRm1IxF44fMRB1QoMIxomFBXSg2/FT0o9u8iwN4nIJgQtvSq4o+YN3KtavXr2"
    imgStr = imgStr & "DDih1LtqzZs2jTql3L1tkIFf40cAjIoNXShwo+clxoC8mHMAE3Ki3oeAqERb6MjgqTQOnFQ11FESd6kUxZjUkFlGmQnCghRROTPCijwBlRAooABEyKoUxE6UMlUKuYtGPnqRSvDR1AjXtSCl0yfOYuBFAZCoaUekigwaP38EIPaAiD0OO5rRc2IKASgdP6rQcTJlj1Tr68+fPo06tfz769+/fw48ufT7++/fv4Sf0oIIMBAxcL5LfIAdLpgtIh"
    imgStr = imgStr & "OeigQQrCzfeBScpkUMgPE6HCQ13yuUBRNoT8pksIDiKAGoiDrBQLA/PtgBoALQ0ilS6kybfBijIQIpouFsz3gm26TDPIBY+dgsJ4771EUYCE3P5gAgE46LAXfReIqIyPAhrSQ2XbYVhlITtYIBQALEi45ZhklmnmmWimqeaabLbp5ptwxinnmht4oIIEFgygpjt/EbmlAdHg8OQkP1RgQw7IkVcBapsRqgIqNAxqHQuogSDpI4vGYgN5D6wIwGW"
    imgStr = imgStr & "S+BWLat6puGIMmOFI3g2eFjDJCy8CQIKfr1GK2g6N5WBCBIGVlxlFrpkpQzRDnvkCoDB2h6Y4DNCgQglazinttNRWa+21Zn0wwQxKrXmCAdrFk0C0Yw7wpS6AmXnCucLUCNYCOXRLT3EUHdSVDag4R80DPALn1QK6XHpMD57i4JVnqEwAzjWVenVCTTC8UMkGNn48xoAPiToygqcxdlVCMChUR0kCPCJgbyMvSPlZWEhSwppGIjty45HWzYgaBh"
    imgStr = imgStr & "ljZKsyAXhnJG+QnGBiLD17x240pEJSggDBEKCDOdZ16ikBY2ZUMJlHK5N0lfiumACZG/SLCgoSk+mhMiBEVmYO4cZCQcvqBiADDiQsWPZWgQAAIfkECAgAAAAsAAAAAIAAgACFBAIEhIKExMLEREJEJCIkpKKk5OLkZGJkFBIUlJKU1NLUNDI0tLK09PL0dHJ0VFZUDAoMjIqMzMrMTEpMLCosrKqs7OrsbGpsHBocnJqc3NrcPDo8vLq8/Pr8f"
    imgStr = imgStr & "Hp8XF5cBAYEhIaExMbEREZEJCYkpKak5ObkZGZkFBYUlJaU1NbUNDY0tLa09Pb0dHZ0XFpcDA4MjI6MzM7MTE5MLC4srK6s7O7sbG5sHB4cnJ6c3N7cPD48vL68/P78fH58////Bv7An3BILBqPyKRyyWw6n9CodEqtWq9YqYnBa2S/4DC0cQKYISmxer2emN+ANHtOn9bgb4itzu8ry3hmNX6EhT8PgWY5hox1IYkACo2TayYwgRtXMhIqlFc"
    imgStr = imgStr & "CKRJXHAhwKwZVLCRvNDqeUjIEbyuuVRYuIw8JPVUVgRi1r00mpXAkLa8Nl4ELwk4eiRmvvpCdzksDiTevEZAALNdLM4kurzneIuFKGYnpnhYgiQS86kkfeCfO54EM9UsBOABQkKMvnhkYBfwpbGIhQ4oSXhZKnEixosWLGDNq3Mixo8ePIEOKHEmyJJ8eNW6cKBDxSgMJ9Ew6iQUHRgUrHRzEA/Fgj/7MJTqK4RlE5QaeTD+VIJJHBV4gHkmRtD"
    imgStr = imgStr & "DYboqIRASjEjHgDcBNKRoSfdVKxEZXqFOywUGBjGyRDZBgtJVigMYbFKLcFuEAKYYVlClY6j2SgaqZfIPpKDixgMYMDokjS55MubLly5gza97MubPnz6BDix5NurRpdRZYRMgh6fSSEBDg7EAlNaZoH4lwtBxiYhyAD7s9yzAM54CRHXBeiL7nzacQHYHmeqbQFfIQ6Hikd17lzfqQFXAeiH7RNdhz8ABGWBDNw9sMJAbWkwaEB4YJ10daQDOlA"
    imgStr = imgStr & "X8SDSmc4AMDtvln4IEIJqjgggw26OCDEEYo4YQUVvgZgBm4w6AMC/7AgQNRCXJAnBkRXNGCDPJJZgEK6PRiUFaDdeONeFMoA4c1ibnhDQRUyIBHQpHZ1ZVzY8T2Bo6DjdAVj1TwYFCJksXQFY1UnBjcYBYIFUheB7IwIgB+KSiDkGagMNaCEqSQAloWtunmm3DGKScSDZRwwgk31FDggQks8wYGJTjDwAQkgLDADbRVRF8gUE7SAnl4QACiRCl0"
    imgStr = imgStr & "BYAAlCyVCJsKdaBlIjtMQg0kGGinzqjlNaJkV/0s5IKlgjTiJyQBSGQUrIswAqsDEj0CK6dOcODAAycEgOQTAXWVgEQSwKoHFAagB8cJHUSxaCL9SSQtJIg5oQGLiQxgqhIafGkGlXILqWAuADgQuUQHZCbiQxQlQNJuRRzM+gYBxy5xx5LjKsEAuG+M4K5EOnxAFQwuXLkEpF2d6UQLNThwQgj9VvQSBzJUKwVyljbqGshdiXzaBbC2ih9fXc"
    imgStr = imgStr & "l1IMmJhGmgCdwFolyCLThQH5ALAohnCQcrFAQAIfkECAgAAAAsAAAAAIAAgACFBAIEhIKExMLEREJEpKKk5OLkZGJkJCIkFBIUlJKU1NLUVFJUtLK09PL0dHJ0NDI0DAoMjIqMzMrMTEpMrKqs7OrsbGpsHBocnJqc3NrcXFpcvLq8/Pr8fHp8PDo8LC4sBAYEhIaExMbEREZEpKak5ObkZGZkJCYkFBYUlJaU1NbUVFZUtLa09Pb0dHZ0NDY0D"
    imgStr = imgStr & "A4MjI6MzM7MTE5MrK6s7O7sbG5sHB4cnJ6c3N7cXF5cvL68/P78fH58PD48////Bv7An3BILBqPyKRyyWw6n9CodEqtWq/YrHbL7SpZHgBqUfKaz1wMYL1G5NDweLQGYbMX8rweSbOzIXuBgRR+bIKHcjmFAB6IjmgGhRuPlEQ8WC0ObAg0Vi0UJhMhGZVSLS4HAB8pWBUsIpdVNQ92IDilUDN+IbgrizK4TRKFEC2VJYsABsFMCYsSlRvJL8xL"
    imgStr = imgStr & "BIsqlSLJA9VKNTB+1JU8KIus3kkMIGw3pKV9fjMc6UoFPTY0Dcw0F2w69OoJXCJBQpmBCBMqXMiwocOHECNKnEixosWLGDNq3BilAg4MDDg64tHBzg0BVzhQsBFhn0gmFgqBUFClha41B2q8VCJjWv6Va3Y67EwSIBmAClQ02ZkxFIkNozSn4PAjtKmREEZ1Tmkxoh1Sq0UULRrhCYOJCF/BFsHqB8Y7tWdiIGDzIRtcOC1EULB7t6/fv4ADCx5"
    imgStr = imgStr & "MuLDhw4gTK17MuLHjx5AjS/YiI+3kJCUWtOt0+YiEcH4cICEwYgZnxhxSLWJhBOiaSYzjLZpgZIAdDY17GL1R+3bu3UZI2IG9WHYh2q1nLAjZuMWNZMw7D5FQx48N6UZy3ARw4zT2IhwMfh9Pvrz58+jTq1/Pvr379/ADS0hhAwNx8hJo2TnAGnCFg1WQwM4iAfTVQgj+AICADS5FIcOAyVAAVwMvFHLAG1H4YNQaN/7EYpUG03jYRAYbshHdU"
    imgStr = imgStr & "Cps6B0Trm3YA1jOGGUCFCmUuIZoVulmFG5PCGcjL1apYRSOThRgIwAigIWMUf09sV0yH8D11CLdRJEDaIuAAI1aNhXygWVPbIBlLQT4RYCGqkRgDBXa+eEDMOaVQEMKFGAY35145qnnnpGVsAMGIjRIXg6asQGCCYI+0kAKJpjgwpYLCTBmOwVUwsCkMyRaTw7mTBMQIsbZ8cGaA5lQIgaONDBXMgUO1EJ1RjWCyFRGXSCiN8OUCIIjpm5YqUA7"
    imgStr = imgStr & "HPlpICBuGFU9JJaIABV/4mBnFC6UqJVAz23IIxQJrLrGC0lGkSs3CdW4IZxPFOsHCHASRtFVMt0OxMO6i7gQRQRGgfCWEzV8cM5CHPRaSwxRtKDtItc+0UIP2o7Q7kIimPDAAR+48KwTLChbhQoykHoXvSWCGVmMG047mQAl8iYdD6olIy92odqBgsidievHDXx9JwK8MNjg8XctSFBzQkEAACH5BAgIAAAALAAAAACAAIAAhgQCBISChERCRMT"
    imgStr = imgStr & "CxCQiJKSipGRiZOTi5BQSFJSSlFRSVNTS1DQyNLSytHRydPTy9AwKDIyKjExKTMzKzCwqLKyqrGxqbOzq7BwaHJyanFxaXNza3Dw6PLy6vHx6fPz6/AQGBISGhERGRMTGxCQmJKSmpGRmZOTm5BQWFJSWlFRWVNTW1DQ2NLS2tHR2dPT29AwODIyOjExOTMzOzCwuLKyurGxubOzu7BweHJyenFxeXNze3Dw+PLy+vHx+fPz+/P///wAAAAAAAA"
    imgStr = imgStr & "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAf+gECCg4SF"
    imgStr = imgStr & "hoeIiYqLjI2Oj5CRkpOUlZaXmJmam5ydig8+EholnqWmnRc4AKsABqevsJMarKw1sbe4iSC0q665v7k/u7wawMa3ArwAOcfNpysItBwvztWeByY0LBHUlicZEbbWkx8dKSPjhAnDAAwn6Y8vIqwK8C3KLD/wjQG8FenzlHXYx0gGLxfpoimLQHCRBV4p0lFQtqyhoh0YWBF4kC6EMgg3LF7UwMHFu3QvWPAiJbJlog8hWDCQMcGlzZs4c+rcybO"
    imgStr = imgStr & "nz59AgwodSrSo0aNIkypdyhTWDAMZWYi79GLGhaaMGrBbxdBSCwirAmBN9AAGxQWVytJCO9ZQDYr+AHxUmsGrQFtDCeD6mvQCLKsVdwu9pSi3Uo1hGQIXeoGCImBLHyaEVFyoxVYAISifGpEMAI1/mkOLHk26tOnTqFOrXs26tevXsGPLnk27NpALNjICwOFgsm23jXlhaPG7UAa4q0C7HiEBBgIZbAVtuMwLwknWHmmBYCbIBnJWhVf3gDtDEI"
    imgStr = imgStr & "Hvqxi0lgDXhCDqyhC0Dq5MPRD4vFC0VkWRhSAa6AHAQ2uzUGSBIB4E2NVqK1AHw0kX+AUXChy1VoKEAMBA3CCDUQTCQK/t4AAPPLhwgCEtmJXfAMUZckEIPGCAgwAR+NbijTjmqOOOPPbo449ABinkkES+tsEM0e3++EEE/AGAgAMV4ngBDxQR8BhlK9jAAAMaoDPJD51RREKUd6VwmQOTpICeDYp1AFcCkqj0HQL63AUgRQh048gHAQKww10Pf"
    imgStr = imgStr & "OelIzf0OShWG3w3VSPCBPhnW4Eid2gj7H1HgmIKwHVpJG5+F1FgG6jISw+TeAeXAHUGNkKTGS4KyQsOUCQDmYG9UIEJJhRg4yQjaKAKChJsWOSwxBZr7LHI3phqjyVwwIoMk1ozQwbl7fSCQcqE58wDBtCHQwM6FUgRnNveycuCLo2HHAi7/mIAcle2JO6bzVyAHwBs2nTed+4doy5c/tnEKkUqNNPAdxTcROV3HlSi5yQrfCfDTRGFoFctJA+"
    imgStr = imgStr & "YQMIqLJAribnKKNfSDQPTIoIkA+hGCw9XRTIAfCIs29IMGGrU7iI7iMqLAJPUULMMN4u0wcKsaBC0Iu8iB2IkJwQgAgMmLL3TAimkkMF1kPygkF43noAezy1GipwEOG6MHEI3VgwXCI+2mBJc6IZtQnWf7thDADLokEDbycITCAAh+QQICAAAACwAAAAAgACAAIYEAgSEgoREQkTEwsQkIiSkoqRkYmTk4uQUEhSUkpRUUlTU0tQ0MjS0srR0cn"
    imgStr = imgStr & "T08vQMCgyMioxMSkzMyswsKiysqqxsamzs6uwcGhycmpxcWlzc2tw8Ojy8urx8enz8+vwEBgSEhoRERkTExsQkJiSkpqRkZmTk5uQUFhSUlpRUVlTU1tQ0NjS0trR0dnT09vQMDgyMjoxMTkzMzswsLiysrqxsbmzs7uwcHhycnpxcXlzc3tw8Pjy8vrx8fnz8/vz///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    imgStr = imgStr & "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH/oBAgoOEhYaHiImKi4yNjo+QkZKTlJWWl5iZmpucnYw3L56io6I7LAAA"
    imgStr = imgStr & "CjekrK2TPwyoqBqutbaKM7Kyobe9vRu6qLy+xK6xsjrFyq2mqKrL0KQXw5cXG9GXB9iFByKoGCHbkR0oACgd4i80wQHijicQsggP2yXBADDU7og1wSPbHu4BWLFv0YpgJ7alELiqoKIAsjKIOwEjmAqHjFbk2LGvQ0VULBpiHJnoRoEULUiqXMmypcuXMGPKnEmzps2bOHPqnLQghYsMKXcuW8EhGI4KQom1ACEQgIektzZ8bFoC6qIfOTSoyC"
    imgStr = imgStr & "EykoKmslD8sIroRVFZGAhGugBWVw2y/occ3KMgqV9bVA7gGip37x8ke3cBmNBL6EXTt5BaBAaQl/AgvsEWrGV6t4HjQT7ucZhk4C4OfXp/yNBFgqOkEwjaortMqIUJExlAPxqQWmAM1qNOqAjGYgBuVhdqpCig9rfx48iTK1/OvLnz59CjS59Ovbr16y5nJNCgIcYM7I0edA5moCv4QhdwNMVxwfqDFCZ89DAkoa2E6h0w6NIw7OBdydKtQJkuF"
    imgStr = imgStr & "mAWmA/TWdBUQ+O1lYx0PDS1mgmBDSadAE3NB8RCd6UwXWb3QMDLCQMKBII20t2gXzC3DaIgWAVSt0OEqEDQ4iAvjCaQDLJBNwNQCR2SQjyyQODheYu8/jBADDEM0COSUEYp5ZRUVmnllVhmqeWWXHbp5ZfMuMAACBTI4BuWBRCpiwNjHXdBCUBZUgFYLhwXwIA4nBnJA1MJ9B1uIOoCwgSS5HCXhZcBIxALklDYFg24JQAWio9ocBcGuLkAll+P"
    imgStr = imgStr & "yNUWA7hxKFCQj/RwVzusXVCiLJtJckpTMJB6maTBgABgJDvUdg9iv+WgKwl/TjKjUXoa98IIJdxqyQgBmOACr2BGK+201FZr7bVZ3pCAAgxoUMCTynwgUwu6okJAsNAMgCE+NrTX0gCrogJDccqIKgsOpq1EAlgiQDNDvAAwutIAd+VLjKUSrkQrWJYps29T4agUwV1IiClTbjB1qmQXWIQqQ6NABaz0wsWkUdKDDTxI4AG9f8EKrjgL7yrJC47"
    imgStr = imgStr & "KAkICk3xQn8wt2SBQBJN4ynMkL7iA52outbAuADJwCkkuTaHwciIPtJBCxzNNrYjQAgU1pY5NAU0lwk1JRKW99ygbJZ9NCXDlUvegICuVA6wjiwyUYrlCBiXkja07gQAAIfkECAgAAAAsAAAAAIAAgACFBAIEhIKExMLEREJEJCIkpKKk5OLkZGJkFBIUlJKU1NLUNDI0tLK09PL0dHJ0VFZUDAoMjIqMzMrMTEpMLCosrKqs7OrsbGpsHBocn"
    imgStr = imgStr & "Jqc3NrcPDo8vLq8/Pr8fHp8XF5cBAYEhIaExMbEREZEJCYkpKak5ObkZGZkFBYUlJaU1NbUNDY0tLa09Pb0dHZ0XFpcDA4MjI6MzM7MTE5MLC4srK6s7O7sbG5sHB4cnJ6c3N7cPD48vL68/P78fH58////Bv7An3BILBqPyKRyyWw6n9CodEqtWq/YrHbL7Xq/4HCzMJpUxOi0tARoAzjquBw5cANe83zTIsoILFc7dnh6hUYGLyBuIA8aVWxu"
    imgStr = imgStr & "cIaTPxwwdm4QklMlMw8MlJMal5iLKqGoVCOlmAOoLRUONalNGqylCpQ2C24zPbRKObeYGZQ+mGfASCHDdgGUM5guykgJzW4xlDeYKdRHItdtIpQ6CG4EDd5HFNcUqCo3Ky426kcs1yz1+kMRwyH7AH8wQIEJBaiAAFvUCHHCx0GEECNKnEixosWLGDNqzNhCho6NtArwaoPAAT2QhVpEK4VDBko9B4ahAPSySYMCKRxRudeMUP5NJTVIATjwS8q"
    imgStr = imgStr & "DayDS/USiAwKmZ1IwhOOxFImHUgimCB02q6qRF6xaSCEQToBXIwFKEZjy4RoEsWeJmDBnp5sUGdduxDUiggTJf1QcDKMAd28RBbmsdBBcasVHw2EEPHAKYEWKDpAza97MubPnz6BDix5NurTp06hTq17NWkqfFJtaM2FB1g2KArKXxLill7UNFi6NCGiGO3ULxgAw5COyohmOoqdj2gER/IeJcONOG2C1Y4iEcMlMQ8IEYgjea11NM2AFY0gLRc"
    imgStr = imgStr & "0em7ZA2c4HIm2HbVCdAhMCmkLosNV02aXGQnMwvGACXziUAkJ6uR3RwA1+AYDDCzpFuEQDAP5q6OGHIIYo4ogklmjiiSimqOKKLLaohQoBnHBDDZiV2MBRdmBglmcyyKAUFR3QwAoIO2pWQYMAgHBDYVG4MMxzmo3nxghTtEDXLeHtZSUrWTqhwDXTQDYcKz49MeYwJ2RWwS0TSKHDNVAZpsItDkwx0i2nZCYIeRlCsd4tD2ymA5JtgJBDFWk1"
    imgStr = imgStr & "9mNmNgRAwwIvVEdFDXci4EKNJuoggaQudurpp6CGKuqoH9pQQAYFnFTiYvAl6QCTlJiQwwUZLBjRBKy0iQozdvgAkTW32DXJbqVEgBA7t7gzSQMDtgGBqvW0cA2sc/DEykP1WHBNh3kUMExx+1yJFSXg3FKgPnfb0FmFDBnkkNgUPdSGCQkINSCvHSQs+kRfdizQJxQitFqoBBDpcGcbNMgHhQz1uYGArXc1hzCnAdVwwgwnlABdFBvcUqabEii"
    imgStr = imgStr & "s2Xa3gEBthNaykieIZ7IisoYtNGwHDiQew8qhI/aQnx1hllhDxwAMQBWpRBcSBAA7"
    
    loadingImage = imgStr

End Function
