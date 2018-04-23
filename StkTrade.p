
/*------------------------------------------------------------------------
    File        : StkTrade.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Mon Apr 23 09:25:47 BST 2018
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

USING StkMkttradeCore.*

DEFINE TEMP-TABLE ttExchangeData NO-UNDO
      FIELD StkSymbol AS CHAR
      FIELD SType     AS CHAR
      FIELD LastDiv   AS DECIMAL
      FIELD FixDiv    AS DECIMAL
      FIELD ParVal    AS DECIMAL
      FIELD DivYield  AS DECIMAL
      FIELD PERatio   AS DECIMAL 
      FIELD GeoMean   AS DECIMAL
      FIELD VWStkPri  AS DECIMAL 
      FIELD TradedPri AS DECIMAL
      FIELD Qty       AS INTEGER
      INDEX idxMain IS PRIMARY StkSymbol.

DEF VAR iCnt AS INTE NO-UNDO.

CREATE ttExchangeData.
ASSIGN ttExchangeData.StkSymbol = "TEA"
       ttExchangeData.SType     = "Common"
       ttExchangeData.LastDiv   = 0
       ttExchangeData.FixDiv    = 0 
       ttExchangeData.TradedPri = 10.5
       ttExchangeData.Qty       = 8
       ttExchangeData.ParVal    = 100.
           
CREATE ttExchangeData.
ASSIGN ttExchangeData.StkSymbol = "POP"
       ttExchangeData.SType     = "Common"
       ttExchangeData.LastDiv   = 8
       ttExchangeData.FixDiv    = 0 
       ttExchangeData.TradedPri = 12
       ttExchangeData.Qty       = 6
       ttExchangeData.ParVal    = 100.
       
CREATE ttExchangeData.
ASSIGN ttExchangeData.StkSymbol = "ALE"
       ttExchangeData.SType     = "Common"
       ttExchangeData.LastDiv   = 23
       ttExchangeData.FixDiv    = 0 
       ttExchangeData.ParVal    = 60
       ttExchangeData.TradedPri = 7
       ttExchangeData.Qty       = 4.
       
CREATE ttExchangeData.
ASSIGN ttExchangeData.StkSymbol = "GIN"
       ttExchangeData.SType     = "Preferred"
       ttExchangeData.LastDiv   = 8
       ttExchangeData.FixDiv    = 2 
       ttExchangeData.ParVal    = 100
       ttExchangeData.TradedPri = 10.5
       ttExchangeData.Qty       = 8.
           
CREATE ttExchangeData.
ASSIGN ttExchangeData.StkSymbol = "JOE"
       ttExchangeData.SType     = "Common"
       ttExchangeData.LastDiv   = 13
       ttExchangeData.FixDiv    = 0 
       ttExchangeData.ParVal    = 250               
       ttExchangeData.TradedPri = 14
       ttExchangeData.Qty       = 11.


/* ***************************  Main Block  *************************** */
DEFINE VARIABLE oClass AS StkMktTradeCore NO-UNDO.
oClass = NEW StkMktTradeCor().

FOR EACH ttExchangeData:

   ASSIGN oClass:dvPriceVal = StkMktTradeCore.dvPriceVal
          oClass:SType      = ttExchangeData.SType
          oClass:LastDiv    = ttExchangeData.LastDiv 
          oClass:FixDiv     = ttExchangeData.FixDiv
          oClass:ParVal     = ttExchangeData.ParVal
          iCnt              = iCnt + 1.   

   oClass:CalcResults(INPUT oClass).
   
   ASSIGN ttExchangeData.DivYield = oClass:DivYield
          ttExchangeData.PERatio  = oClass:PERatio 
          ttExchangeData.PERatio  = StkMktTradeCore.dvPriceVal / ttExchangeData.LastDiv
          ttExchangeData.GeoMean  = EXP(StkMktTradeCore.dvPriceVal, iCnt)
          ttExchangeData.VWStkPri = ttExchangeData.VWStkPri + ((ttExchangeData.TradedPri * ttExchangeData.Qty) / ttExchangeData.Qty).

END.

DELETE OBJECT oClass.