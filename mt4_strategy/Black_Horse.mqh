//+---------------------------------------------------
 
//|                                                  Black_Horse.mqh |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class heima
  {
public:
     heima()
     {
      GF_MagicNumberBuy        = 25325;
      GF_MagicNumberSell       = 35325;
      GF_DrawAveragePrice=true;  // Draw average price line
      GF_DualTrade          = false;  // Allow buy and sell
      GF_NewTradeBuy        = true;   // Allow buys
      GF_NewTradeSell       = true;   // Allow sells 
      GFS_Para1="5、15、30、60";    //黑马交易图表周期---------------------------
      GFS_PERIOD=PERIOD_M5;//黑马交易图表周期

      GF_CheckNewBar=false;   // on new bar
      GF_MaxTrades=13;     // Max number of open orders
      GF_PipStep=250;   // Step between pips
      GF_PipStepExponent    = 1.0;    // Exponent
      GF_StaticTakeProfit   = 150;     // Fixed Take Profit


      GF_ProfitPersent      = 30;     // Percent to close(10...50) // percent to close
      GF_SecondProfitPersent = 50;    // Percent to close previous last order 

      GF_StartLot           = 0.1;    // Initial lot size
      GF_LotIncrement       = 0.01;    // Increment lot to add  
      //GF_MaxLot             = 7;     // Maximum lot size
      GF_UseAutoLot         = false;  // Use Auto-lot ... % deposit
      GF_AutoLot            = 0.5;    // Percent - calculate lot size from equity
      GF_AutoLotIncrement   = 0.3;    // Percent of lot to add


      GF_iMA_Period         = 700;
      GF_iMA_OpenDistance   = 600;

      GF_DDBuffer=0;

      GF_TimePrev=0;

      GF_OrderSended=0;
      GF_TotalBuyOrders=0;
      GF_TotalSellOrders=0;

      GF_LastOrderComment="";

     }

   int               GetSignal(string sym);
   void              Array_init();

   int               GFS_main(string sym);
   void              CheckTakeProfit(string sym);
   int               CountOfOrders(int mNumber,string sym);
   double            GetLotForStep(int mNumber,int OrdCount,string sym);
   double            GetStartLot(string sym);
   double            GetPipstepForStep(int CurrStep);
   double            FindFirstOrderParameter(int mNumber,string ParamName,string sym);
   double            FindLastOrderParameter(int mNumber,string ParamName,string sym);
   double            GetClosedProfit(int mNumber,string sym);
   bool              ModifyTakeProfit(double takeprofit,string sym);
   int               SendMarketOrder(int Type,double GFS_Lots,int TP,int SL,int GFS_Magic,string Cmnt,string sym);
   double            IIFd(bool condition,double ifTrue,double ifFalse,string sym);
   void              CheckOverlapping(string sym);
   int               LidingProfitOrder(int mNumber,string sym);
   int               CloseProfitOrder(int mNumber,string sym);
   int               CloseSelectOrder(int mNumber,string sym);

public:
   int               GF_MagicNumberBuy;
   int               GF_MagicNumberSell;

   bool              GF_DrawAveragePrice;  // Draw average price line
   bool              GF_DualTrade;  // Allow buy and sell
   bool              GF_NewTradeBuy;   // Allow buys
   bool              GF_NewTradeSell;   // Allow sells 
   string            GFS_Para1;    //黑马交易图表周期---------------------------
   int               GFS_PERIOD;//黑马交易图表周期

   bool              GF_CheckNewBar;   // on new bar
   int               GF_MaxTrades;     // Max number of open orders
   double            GF_PipStep;   // Step between pips
   double            GF_PipStepExponent;    // Exponent
   double            pipStepExponent;    // Exponent
   int               GF_StaticTakeProfit;     // Fixed Take Profit

   double            GF_ProfitPersent;     // Percent to close(10...50) // percent to close
   double            GF_SecondProfitPersent;    // Percent to close previous last order 

   double            GF_StartLot;    // Initial lot size
   double            GF_LotIncrement;    // Increment lot to add  
   //double            GF_MaxLot;     // Maximum lot size
   bool              GF_UseAutoLot;  // Use Auto-lot ... % deposit
   double            GF_AutoLot;    // Percent - calculate lot size from equity
   double            GF_AutoLotIncrement;    // Percent of lot to add

   int               GF_iMA_Period;
   int               GF_iMA_OpenDistance;

   double            GF_DDBuffer;

   int               GF_TimePrev;

   int               GF_OrderSended;
   int               GF_TotalBuyOrders;
   int               GF_TotalSellOrders;
   int               GF_Lpos;
   int               GF_Lpos1;
   int               GF_Cpos;

   //double 3;
   //double GF_mPipStep;
   //double vPoint;
   double            GF_PriceTarget;
   double            GF_AveragePrice;
   double            GF_LastBuyPrice;
   double            GF_LastSellPrice;
   //double GF_BuySummLot,GF_SellSummLot,GF_TotalProfitBuy,GF_TotalProfitSell;
   double            GF_BLot,GF_SLot;
   double            GF_Cprofit;
   double            GF_Lprofit;
   double            GF_Lprofit1;
   double            GF_PrcCL;

   string            GF_LastOrderComment;
   string            GF_BComment;
   string            GF_SComment;
  }hei_ma_strategy;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void heima::Array_init()
  {
//   for(int i=0;i<5;i++)
//     {
//      heima_postrade[i].trade_count=0;
//      heima_postrade[i].lot=0;
//      heima_postrade[i].lot_b=0;
//      heima_postrade[i].lot_s=0;
//      heima_postrade[i].profit=0;
//
//     }

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int  heima::GFS_main(string sym)
  {
            
   if(GF_StaticTakeProfit < MarketInfo(sym,MODE_STOPLEVEL) )
     GF_StaticTakeProfit = (int)MarketInfo(sym,MODE_STOPLEVEL);
     
   GF_StartLot=0.01;
   GF_MaxTrades=20;
   //GF_MaxLot=7;
   pipStepExponent=GF_PipStepExponent+SymbolInfoInteger(sym,SYMBOL_SPREAD);

   CheckOverlapping(sym);
// New buy orders
   GF_TotalBuyOrders=CountOfOrders(GF_MagicNumberBuy,sym);
   if(GF_TotalBuyOrders>0 && GF_TotalBuyOrders<GF_MaxTrades)
     {
      GF_OrderSended=-1;
      GF_LastBuyPrice=FindLastOrderParameter(GF_MagicNumberBuy,"price",sym);

      if(GF_LastBuyPrice-SymbolInfoDouble(sym,SYMBOL_ASK)>=GetPipstepForStep(GF_TotalBuyOrders+1)*SymbolInfoDouble(sym,SYMBOL_POINT))
        {
         GF_BLot=GetLotForStep(GF_MagicNumberBuy,GF_TotalBuyOrders,sym);
         GF_BComment=StringSubstr(GF_LastOrderComment,0,StringFind(GF_LastOrderComment,"|",0))+"|";
         GF_OrderSended=SendMarketOrder(OP_BUY,GF_BLot,0,0,GF_MagicNumberBuy,GF_BComment,sym);
        }
     }
// New sell orders
   GF_TotalSellOrders=CountOfOrders(GF_MagicNumberSell,sym);
   if(GF_TotalSellOrders>0 && GF_TotalSellOrders<GF_MaxTrades)
     {
      GF_OrderSended=-1;
      GF_LastSellPrice=FindLastOrderParameter(GF_MagicNumberSell,"price",sym);

      if(SymbolInfoDouble(sym,SYMBOL_BID)-GF_LastSellPrice>=GetPipstepForStep(GF_TotalSellOrders+1)*SymbolInfoDouble(sym,SYMBOL_POINT))
        {
         GF_SLot=GetLotForStep(GF_MagicNumberSell,GF_TotalSellOrders,sym);
         GF_SComment=StringSubstr(GF_LastOrderComment,0,StringFind(GF_LastOrderComment,"|",0))+"|";
         GF_OrderSended=SendMarketOrder(OP_SELL,GF_SLot,0,0,GF_MagicNumberSell,GF_SComment,sym);
        }
     }

   CheckTakeProfit(sym);

   int TradeSignal=GetSignal(sym);

// New buy series ...
   if(GF_TotalBuyOrders==0 && GF_NewTradeBuy && TradeSignal>0 && (GF_DualTrade==true || GF_TotalSellOrders==0))
      SendMarketOrder(OP_BUY,GetStartLot(sym),GF_StaticTakeProfit,0,GF_MagicNumberBuy,IntegerToString(TimeCurrent())+"|",sym);

// New sell series ...
   if(GF_TotalSellOrders==0 && GF_NewTradeSell && TradeSignal<0 && (GF_DualTrade==true || GF_TotalBuyOrders==0))
      SendMarketOrder(OP_SELL,GetStartLot(sym),GF_StaticTakeProfit,0,GF_MagicNumberSell,IntegerToString(TimeCurrent())+"|",sym);
   return -1;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void heima::CheckTakeProfit(string sym)
  {
//BUY
   GF_TotalBuyOrders=CountOfOrders(GF_MagicNumberBuy,sym);

   GF_PriceTarget=0;
   GF_AveragePrice=0;
   if(GF_TotalBuyOrders>0)
     {
      GF_PriceTarget=FindFirstOrderParameter(GF_MagicNumberBuy,"price",sym)+GF_StaticTakeProfit*SymbolInfoDouble(sym,SYMBOL_POINT);
     }

   for(int i=0; i<OrdersTotal(); i++)
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==sym && OrderMagicNumber()==GF_MagicNumberBuy)
            if(NormalizeDouble(OrderTakeProfit(),(int)SymbolInfoInteger(sym,SYMBOL_DIGITS))!=NormalizeDouble(GF_PriceTarget,(int)SymbolInfoInteger(sym,SYMBOL_DIGITS))) ModifyTakeProfit(GF_PriceTarget,sym);

   GF_PriceTarget=0;
   GF_AveragePrice=0;
   GF_TotalSellOrders=CountOfOrders(GF_MagicNumberSell,sym);
   if(GF_TotalSellOrders>0)
     {
      GF_PriceTarget=FindFirstOrderParameter(GF_MagicNumberSell,"price",sym)-GF_StaticTakeProfit*SymbolInfoDouble(sym,SYMBOL_POINT);
     }

   for(int i=0; i<OrdersTotal(); i++)
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==sym && OrderMagicNumber()==GF_MagicNumberSell)
            if(NormalizeDouble(OrderTakeProfit(),(int)SymbolInfoInteger(sym,SYMBOL_DIGITS))!=NormalizeDouble(GF_PriceTarget,(int)SymbolInfoInteger(sym,SYMBOL_DIGITS))) ModifyTakeProfit(GF_PriceTarget,sym);


  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int heima::GetSignal(string sym)
  {
   int Signal=0;
   double iMA_Signal=iMA(sym,GFS_PERIOD,GF_iMA_Period,0,MODE_SMMA,PRICE_CLOSE,0);
   if(SymbolInfoDouble(sym,SYMBOL_POINT)==0)return(0);
   double Ma_Bid_Diff=MathAbs(iMA_Signal-SymbolInfoDouble(sym,SYMBOL_BID))/SymbolInfoDouble(sym,SYMBOL_POINT);
//Alert(sym," ",Ma_Bid_Diff,"   ",iMA_Signal);  
   if(Ma_Bid_Diff > GF_iMA_OpenDistance && SymbolInfoDouble(sym,SYMBOL_BID) > iMA_Signal) Signal = -1;
   if(Ma_Bid_Diff > GF_iMA_OpenDistance && SymbolInfoDouble(sym,SYMBOL_BID) < iMA_Signal) Signal = 1;
//Alert(sym,": ",Ma_Bid_Diff,":",GF_iMA_OpenDistance,":",iMA_Signal,":",Signal);  
   return(Signal);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int heima::CountOfOrders(int mNumber,string sym)
  {
   int count = 0;
   for(int i = 0; i < OrdersTotal(); i++)
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
         if((OrderSymbol() == sym) && (OrderMagicNumber() == mNumber))
            if((OrderType() == OP_SELL) || (OrderType() == OP_BUY))
               count++;

   return(count);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double heima::GetLotForStep(int mNumber,int OrdCount,string sym)
  {
   double CurrLot=0;
   double LastOrderLot=FindLastOrderParameter(mNumber,"lot",sym);

   if(GF_UseAutoLot==true)
     {
      if(LastOrderLot!=0) CurrLot=NormalizeDouble(LastOrderLot+NormalizeDouble(AccountEquity()*GF_AutoLotIncrement/10000,2)*OrdCount,2);
     }
   else
     {
      if(LastOrderLot!=0) CurrLot=NormalizeDouble(LastOrderLot+GF_LotIncrement*OrdCount,2);
     }

// 
   //if(CurrLot>GF_MaxLot) CurrLot=GF_MaxLot;
   if(CurrLot<GF_StartLot) CurrLot=GF_StartLot;

   if(CurrLot==0) CurrLot=GF_StartLot;

   return(CurrLot);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double heima::GetStartLot(string sym)
  {
   double FirstLot=0;

   if(GF_UseAutoLot==true)
     {
      FirstLot=NormalizeDouble(AccountEquity()*GF_AutoLot/10000,2);
     }
   else
     {
      FirstLot=GF_StartLot;
     }

   //if(FirstLot>GF_MaxLot) FirstLot=GF_MaxLot;
   if(FirstLot<GF_StartLot) FirstLot=GF_StartLot;

   return(FirstLot);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double heima::GetPipstepForStep(int CurrStep)
  {
   double CurrPipstep=NormalizeDouble(GF_PipStep*MathPow(GF_PipStepExponent,CurrStep),0);

   return(CurrPipstep);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double heima::FindFirstOrderParameter(int mNumber,string ParamName,string sym)
  {
   int mOrderTicket=0;
   double mOrderPrice=0;
   double mOrderLot=0;
   double mOrderProfit=0;
   int PrevTicket = 0;
   int CurrTicket = 0;
   for(int i=OrdersTotal()-1; i>=0; i--)
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==sym && OrderMagicNumber()==mNumber)
           {
            CurrTicket=OrderTicket();
            if(CurrTicket<PrevTicket || PrevTicket==0)
              {
               PrevTicket=CurrTicket;

               mOrderPrice=OrderOpenPrice();
               mOrderTicket=OrderTicket();
               mOrderLot=OrderLots();
               mOrderProfit=OrderProfit()+OrderSwap()+OrderCommission();
              }
           }

   if(ParamName == "price") return(mOrderPrice);
   else if(ParamName == "ticket") return(mOrderTicket);
   else if(ParamName == "lot") return(mOrderLot);
   else if(ParamName == "profit") return(mOrderProfit);
   return 0;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double heima::FindLastOrderParameter(int mNumber,string ParamName,string sym)
  {
   int mOrderTicket=0;
   double mOrderPrice=0;
   double mOrderLot=0;
   double mOrderProfit=0;
   int PrevTicket = 0;
   int CurrTicket = 0;

   for(int i=OrdersTotal()-1; i>=0; i--)
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==sym && OrderMagicNumber()==mNumber)
           {
            CurrTicket=OrderTicket();
            if(CurrTicket>PrevTicket)
              {
               PrevTicket=CurrTicket;

               mOrderPrice=OrderOpenPrice();
               mOrderTicket=OrderTicket();
               mOrderLot=OrderLots();
               mOrderProfit=OrderProfit()+OrderSwap()+OrderCommission();
               GF_LastOrderComment=OrderComment();
              }
           }

   if(ParamName == "price") return(mOrderPrice);
   else if(ParamName == "ticket") return(mOrderTicket);
   else if(ParamName == "lot") return(mOrderLot);
   else if(ParamName == "profit") return(mOrderProfit);
   return 0;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double heima::GetClosedProfit(int mNumber,string sym)
  {
   double ClosedProfit=0;

   for(int i=OrdersHistoryTotal(); i>0; i--)
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY))
         if(OrderSymbol()==sym && OrderMagicNumber()==mNumber)
            if(StringSubstr(GF_LastOrderComment,0,StringFind(GF_LastOrderComment,"|",0))==StringSubstr(OrderComment(),0,StringFind(OrderComment(),"|",0)))
               ClosedProfit=ClosedProfit+OrderProfit();

   return(ClosedProfit);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool heima::ModifyTakeProfit(double takeprofit,string sym)
  {
   while(!IsStopped())
     {
      if(IsTradeContextBusy())
        {
         Sleep(300);
         continue;
        }
      if(!IsTradeAllowed())
        {
         return(False);
        }
      if(!OrderModify(OrderTicket(),OrderOpenPrice(),0,NormalizeDouble(takeprofit,(int)SymbolInfoInteger(sym,SYMBOL_DIGITS)),0,Yellow))
        {
         int Err=GetLastError();
         //Print("!!! Error(",Err,"): ",ErrorDescription(Err));
         return(False);
        }
      else
        {
         break;
        }
     }

   return(True);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int heima::SendMarketOrder(int Type,double GFS_Lots,int TP,int SL,int GFS_Magic,string Cmnt,string sym)
  {
   double Price,Take,Stop;
   int Ticket=-1,Color,Err;
   int ErrorCount=0;
   double  bid=MarketInfo(sym,MODE_BID);
    double  ask=MarketInfo(sym,MODE_ASK);
   while(!IsStopped())
     {
      if(ErrorCount > 5) return(0);
      if(!IsConnected())
        {
         ErrorCount=ErrorCount+1;
         Sleep(1000);
        }
      if(IsTradeContextBusy())
        {
         Sleep(3000);
         continue;
        }
      switch(Type)
        {
         case OP_BUY:
            Price= NormalizeDouble(MarketInfo(sym,MODE_ASK),(int)SymbolInfoInteger(sym,SYMBOL_DIGITS));
            Take = IIFd(TP == 0, 0, NormalizeDouble( Price + TP * SymbolInfoDouble(sym,SYMBOL_POINT), (int)SymbolInfoInteger(sym,SYMBOL_DIGITS)),sym);
            Stop = IIFd(SL == 0, 0, NormalizeDouble( Price - SL * SymbolInfoDouble(sym,SYMBOL_POINT), (int)SymbolInfoInteger(sym,SYMBOL_DIGITS)),sym);
            Color= Blue;
            break;
         case OP_SELL:
            Price= NormalizeDouble(MarketInfo(sym,MODE_BID),(int)SymbolInfoInteger(sym,SYMBOL_DIGITS));
            Take = IIFd(TP == 0, 0, NormalizeDouble( Price - TP * SymbolInfoDouble(sym,SYMBOL_POINT), (int)SymbolInfoInteger(sym,SYMBOL_DIGITS)),sym);
            Stop = IIFd(SL == 0, 0, NormalizeDouble( Price + SL * SymbolInfoDouble(sym,SYMBOL_POINT), (int)SymbolInfoInteger(sym,SYMBOL_DIGITS)),sym);
            Color= Red;
            break;
         default:
            return(-1);
        }
      if(IsTradeAllowed())
        {
         if(Type==OP_BUY)
           {
           // Ticket=(int)Ctrade_hm.MN_OpenTrade(sym,OP_BUY,GFS_Lots,0,Stop,Take,Cmnt,GFS_Magic,true,1,true,Perlotscoin);
            int o_send = OrderSend(sym,OP_BUY,GFS_Lots,ask,20,Stop,Take,Cmnt,GFS_Magic,0,clrRed);
          

           }
         else
           {
            if(Type==OP_SELL)
              {
               //Ticket=(int)Ctrade_hm.MN_OpenTrade(sym,OP_SELL,GFS_Lots,0,Stop,Take,Cmnt,GFS_Magic,true,1,true,Perlotscoin);
            int o_send_= OrderSend(sym,OP_SELL,GFS_Lots,bid,20,Stop,Take,Cmnt,GFS_Magic,0,clrGreen);
            //Alert(3);
               
              // Ticket=OpenSell(sym,GFS_Lots,Stop,Take,Cmnt,GFS_Magic,true);
              }
           }
         //        Ticket = OrderSend(sym, Type, Lots, Price, 2*3, Stop, Take, Cmnt, GFS_Magic, 0, Color);
         //int OpenSell(string sym,double lot,double sto=0.0,double tak=0.0,string com="",int mag=0) 
         //int OpenBuy(string sym,double lot,double sto=0.0,double tak=0.0,string com="",int mag=0) 

         if(Ticket<0)
           {
            Err=GetLastError();
            if(Err==4 || /* SERVER_BUSY */
               Err == 129 || /* INVALID_PRICE */
               Err == 135 || /* PRICE_CHANGED */
               Err == 137 || /* BROKER_BUSY */
               Err == 138 || /* REQUOTE */
               Err == 146 || /* TRADE_CONTEXT_BUSY */
               Err == 136 )  /* OFF_QUOTES */
              {
               Sleep(3000);
               continue;
              }
            else
              {
               break;
              }
           }
         break;
        }
      else
        {
         break;
        }
     }

   return(Ticket);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double heima::IIFd(bool condition,double ifTrue,double ifFalse,string sym)
  {
   if(condition) return(ifTrue); else return(ifFalse);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void heima::CheckOverlapping(string sym)
  {
//BUY--->
   GF_TotalBuyOrders=CountOfOrders(GF_MagicNumberBuy,sym);
   if(GF_TotalBuyOrders>=2)
     {
      GF_Lpos = 0; GF_Cpos = 0; GF_Lprofit = 0; GF_Cprofit = 0;
      GF_Lpos = LidingProfitOrder(GF_MagicNumberBuy,sym);
      GF_Cpos = CloseProfitOrder(GF_MagicNumberBuy,sym);

      if(GF_Lprofit>0 && GF_Lprofit1<=0)
        {
         if(GF_Lprofit+GF_Cprofit>0 && (GF_Lprofit+GF_Cprofit)*100/GF_Lprofit>pipStepExponent)
           {
            GF_Lpos1=0;
            CloseSelectOrder(GF_MagicNumberBuy,sym);
           }
        }
      else if(GF_Lprofit>0 && GF_Lprofit1>0)
        {
         if(GF_Lprofit+GF_Lprofit1+GF_Cprofit>0 && (GF_Lprofit+GF_Lprofit1+GF_Cprofit)*100/(GF_Lprofit+GF_Lprofit1)>GF_SecondProfitPersent) CloseSelectOrder(GF_MagicNumberBuy,sym);
        }
     }
//<---BUY

//SELL--->
   GF_TotalSellOrders=CountOfOrders(GF_MagicNumberSell,sym);
   if(GF_TotalSellOrders>=2)
     {
      GF_Lpos = 0; GF_Cpos = 0; GF_Lprofit = 0; GF_Cprofit = 0;
      GF_Lpos = LidingProfitOrder(GF_MagicNumberSell,sym);
      GF_Cpos = CloseProfitOrder(GF_MagicNumberSell,sym);

      if(GF_Lprofit>0 && GF_Lprofit1<=0)
        {
         if(GF_Lprofit+GF_Cprofit>0 && (GF_Lprofit+GF_Cprofit)*100/GF_Lprofit>pipStepExponent)
           {
            GF_Lpos1=0;
            CloseSelectOrder(GF_MagicNumberSell,sym);
           }
        }
      if(GF_Lprofit>0 && GF_Lprofit1>0)
        {
         if(GF_Lprofit+GF_Lprofit1+GF_Cprofit>0 && (GF_Lprofit+GF_Lprofit1+GF_Cprofit)*100/(GF_Lprofit+GF_Lprofit1)>GF_SecondProfitPersent) CloseSelectOrder(GF_MagicNumberSell,sym);
        }
     }
//<---SELL
  }
//======================================== Most profitable order =======================================
int heima::LidingProfitOrder(int mNumber,string sym)
  {
   GF_Lprofit1=0;
   GF_Lpos1=0;
   int TotalOrders= CountOfOrders(mNumber,sym);
   double profit  = 0;
   int    Pos     = 0;
   for(int i=0; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         if((OrderSymbol()==sym) && (OrderMagicNumber()==mNumber))
           {
            if(OrderType()==OP_SELL || OrderType()==OP_BUY)
              {
               profit = OrderProfit();
               Pos    = OrderTicket();
               if(profit>0 && profit>GF_Lprofit) 
                 {
                  // Previous value
                  GF_Lprofit1 = GF_Lprofit;
                  GF_Lpos1    = GF_Lpos;

                  // Maximum value
                  GF_Lprofit = profit;
                  GF_Lpos    = Pos;
                 }
              }
           }
        }
     }
   return (GF_Lpos);
  }
//========================================  Least Profitable Order =======================================
int heima::CloseProfitOrder(int mNumber,string sym)
  {
   double profit  = 0;
   int    Pos     = 0;
   for(int trade = OrdersTotal() - 1; trade >= 0; trade--) 
     {
      if(OrderSelect(trade, SELECT_BY_POS, MODE_TRADES))  
        {
         if((OrderSymbol()==sym) && (OrderMagicNumber()==mNumber))
           {
            if(OrderType()==OP_SELL || OrderType()==OP_BUY) 
              {
               profit = OrderProfit();
               Pos    = OrderTicket();
               if(profit<0 && profit<GF_Cprofit) 
                 {
                  GF_Cprofit = profit;
                  GF_Cpos    = Pos;
                 }
              }
           }
        }
     }
   return (GF_Cpos);
  }
//==========================================  Closing Orders ===============================================
int heima::CloseSelectOrder(int mNumber,string sym)
  {
   int error=0;
   int error1 = 0;
   int error2 = 0;
   int Result = 0;
//                       ----------------------  Last Order -----------------------                            
 int digit = (int)MarketInfo(sym, MODE_DIGITS);
   while(error1==0)
     {
      RefreshRates();
      int i = OrderSelect(GF_Lpos, SELECT_BY_TICKET, MODE_TRADES);
      if(i!=1) 
        {
         //Print ("Error! Not possible to select most profitable order . Operation cancelled.");
         return (0);
        }
      if((OrderSymbol()==sym) && (OrderMagicNumber()==mNumber)) 
        {
         if(OrderType()==OP_BUY) 
           {
            error1=(OrderClose(OrderTicket(),OrderLots(),NormalizeDouble(SymbolInfoDouble(sym,SYMBOL_BID),digit ),3,Blue));
            if(error1==1) 
              {
               //Print ("Leading Order closed successfully"); 
               Sleep(500);
                 } else {
               //Print ("Error closing leading order, Repeat Operation. ");                     
              }
           }
         //                        -----------------------------------------------------               
         if(OrderType()==OP_SELL) 
           {
            error1=(OrderClose(OrderTicket(),OrderLots(),NormalizeDouble(SymbolInfoDouble(sym,SYMBOL_ASK),digit ),3,Red));
            if(error1==1) 
              {
               //Print ("Leading Order closed successfully"); 
               Sleep(500);
                 } else {
               //Print ("Error closing leading order, Repeat Operation. ");                     
              }
           }
        }
     }

//                       ---------------------- Previous Last  -----------------------                            		
   if(GF_Lpos1!=0)
     {
      while(error2==0) 
        {
         RefreshRates();
         int i = OrderSelect(GF_Lpos1, SELECT_BY_TICKET, MODE_TRADES);
         if(i!=1) 
           {
            //Print ("Error! Not possible to select previous most profitable order . Operation cancelled.");
            return (0);
           }
         if((OrderSymbol()==sym) && (OrderMagicNumber()==mNumber)) 
           {
            if(OrderType()==OP_BUY) 
              {
               error2=(OrderClose(OrderTicket(),OrderLots(),NormalizeDouble(SymbolInfoDouble(sym,SYMBOL_BID),digit ),3,Blue));
               if(error2==1) 
                 {
                  //Print ("Previous leading order closed successfully");
                  Sleep(500);
                    } else {
                  //Print ("Error closing previous leading order, Repeat Operation. ");                     
                 }
              }
            //                        -----------------------------------------------------               
            if(OrderType()==OP_SELL) 
              {
               error2=(OrderClose(OrderTicket(),OrderLots(),NormalizeDouble(SymbolInfoDouble(sym,SYMBOL_ASK),digit ),3,Red));
               if(error2==1) 
                 {
                  //Print ("Previous leading order closed successfully"); 
                  Sleep(500);
                    } else {
                  //Print ("Error closing previous leading order, Repeat Operation. ");                     
                 }
              }
           }
        }
     }
//								----------- Selected (Least profitable order ) -----------
   while(error==0) 
     {
      RefreshRates();
      int i = OrderSelect(GF_Cpos, SELECT_BY_TICKET, MODE_TRADES);
      if(i!=1) 
        {
         //Print ("Error! Not possible to select least profitable order. Operation cancelled");
         return (0);
        }
      if((OrderSymbol()==sym) && (OrderMagicNumber()==mNumber)) 
        {
         if(OrderType()==OP_BUY) 
           {
            error=(OrderClose(OrderTicket(),OrderLots(),NormalizeDouble(SymbolInfoDouble(sym,SYMBOL_BID),digit ),3,Blue));
            if(error==1) 
              {
               //Print ("Order closed successfully."); 
               Sleep(500);
                 } else {
               //Print ("Error during Order Close. Repeat operation.  ");                    
              }
           }
         //                             --------------------------------------------------                
         if(OrderType()==OP_SELL) 
           {
            error=(OrderClose(OrderTicket(),OrderLots(),NormalizeDouble(SymbolInfoDouble(sym,SYMBOL_ASK),digit ),3,Red));
            if(error==1) 
              {
               //Print ("Order closed successfully."); 
               Sleep(500);
                 } else {
               //Print ("Error during Order Close. Repeat operation.  ");                     
              }
           }
        }
     }

   Result=1;
   return (Result);
  }
//+------------------------------------------------------------------+
