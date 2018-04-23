/*********************************************************************
   File        : StkMktTradeCore.cls
   Description : Stock Market Trading Core Class
   Author(s)   : Karikalan
********************************************************************
                         Modification History
********************************************************************  
 
********************************************************************/
USING System.*                     FROM ASSEMBLY.
USING System.IO.*                  FROM ASSEMBLY.
USING System.Text.*                FROM ASSEMBLY.
USING System.Windows.Forms.*       FROM ASSEMBLY.

ROUTINE-LEVEL ON ERROR UNDO, THROW.
 
CLASS StkMktTradeCore USE-WIDGET-POOL:
   
                     
   DEFINE PUBLIC PROPERTY dvPriceVal AS DECIMAL NO-UNDO
   GET():
      RETURN dvPriceVal.
   END GET.

   SET(INPUT cValue AS DECIMAL):
       ASSIGN dvPriceVal = cValue.
   END SET.
   
   DEFINE PUBLIC PROPERTY DivYield AS DECIMAL NO-UNDO
   GET():
      RETURN DivYield.
   END GET.

   SET(INPUT cValue AS DECIMAL):
       ASSIGN DivYield = cValue.
   END SET.
   
   DEFINE PUBLIC PROPERTY SType AS CHAR NO-UNDO
   GET():
      RETURN SType.
   END GET.

   SET(INPUT cValue AS CHAR):
       ASSIGN SType = cValue.
   END SET.
   
   DEFINE PUBLIC PROPERTY LastDiv AS DECIMAL NO-UNDO
   GET():
      RETURN LastDiv.
   END GET.

   SET(INPUT cValue AS DECIMAL):
       ASSIGN LastDiv = cValue.
   END SET.
   
   DEFINE PUBLIC PROPERTY FixDiv AS DECIMAL NO-UNDO
   GET():
      RETURN FixDiv.
   END GET.

   SET(INPUT cValue AS DECIMAL):
       ASSIGN FixDiv = cValue.
   END SET.

   DEFINE PUBLIC PROPERTY ParVal AS DECIMAL NO-UNDO
   GET():
      RETURN ParVal.
   END GET.

   SET(INPUT cValue AS DECIMAL):
       ASSIGN ParVal = cValue.
   END SET.
   
   DEFINE PUBLIC PROPERTY PERatio AS DECIMAL NO-UNDO
   GET():
      RETURN ParVal.
   END GET.

   SET(INPUT cValue AS DECIMAL):
       ASSIGN ParVal = cValue.
   END SET.

   CONSTRUCTOR STATIC StkMktTradeCore (  ):
  
   END CONSTRUCTOR.
    

   DESTRUCTOR STATIC StkMktTradeCore (  ):
  
   END DESTRUCTOR.
    

   METHOD PUBLIC VOID CalcResults(oCalc AS StkMktTradeCore):
        
     ASSIGN oCalc.DivYield = IF oCalc.SType = "Common" THEN (oCalc.LastDiv / oCalc.dvPriceVal)
                                                  ELSE ((oCalc.FixDiv * oCalc.ParVal ) / oCalc.dvPriceVal)) 
            oCalc.PERatio  = oCalc.dvPriceVal / oCalc.LastDiv.
        
     CATCH ex AS Progress.Lang.Error:
        UNDO, THROW ex.
     END CATCH.

   END METHOD.
  
END CLASS.

