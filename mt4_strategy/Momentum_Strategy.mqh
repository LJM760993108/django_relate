
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict

#include <main_1/trade_.mqh>

 Trade tra_ord;//开平仓 类对象
 
class Momentum 
  {  
public:
   Momentum();                             //|  构造函数是不用定义类型的
   void Trade_Main(string sym);                      //|  交易主函数 

private: 
   void CloseOrder(string sym);                      //|  单边平仓函数
   void CheckForOpen(string sym);                    //|  选择开仓函数
   void CheckForClose(string sym);                   //|  选择平仓函数
   void Change_Depend_On_K(string sym);              //|  入场后N根K线调A策略止损、M根K线取消挂单
   void TrailingStop_Magic(int magic, string sym);     //|  追踪止损函数
   void DeleteOrder(int ordertype, string sym);        //|  删除挂单
   int  Count_Order(string sym);                     //|  计算订单
   double Pending_Order_Op(int ordertype, string sym); //|  读挂单价格        
private: 
   int trend; 
   int MA_period;
   int ATR_lookback_num; 
   int Strategy_A_ATR_period; 
   int Strategy_B_ATR_period; 
   int max_sl;
   int min_sl;
   int take_profit;
   int pending_order_level;
   int pending_order_sl;
   int pending_order_tp;
   int First_A_TrailingStop;
   int A_TrailingStop;
   int First_B_TrailingStop;
   int B_TrailingStop;
   int A_MinProfit;
   int B_MinProfit;
   int K_num_to_sl;
   int K_num_to_delete_pending;
   int magic1;
   int magic2;
   int magic3;
   int magic4;
   int count_A;
   int count_B;
   
   double A_reference;  
   double B_reference;  
   double max_profit;
   double min_profit;  
   double Lot;
   double Strategy_A_ATR_increase;
   double Strategy_B_ATR_increase;
   double sl_level;
   
   string comment;

  }   Momentum_Strategy ;

Momentum :: Momentum(void)
  {
   Lot = 1.0;
   trend = 30; 
   MA_period = 21;
   ATR_lookback_num = 1; 
   Strategy_A_ATR_period = 21; 
   Strategy_B_ATR_period =37; 
   Strategy_A_ATR_increase = 2.4;
   Strategy_B_ATR_increase = 2.6;
   sl_level = 0.65;
   max_sl = 40;
   min_sl = 25;
   take_profit = 140;
   pending_order_level = 40;
   pending_order_sl = 110;
   pending_order_tp = 70;
   First_A_TrailingStop = 60;
   A_TrailingStop = 80;
   First_B_TrailingStop = 130;
   B_TrailingStop = 230;
   A_MinProfit = 10;
   B_MinProfit = 96;
   max_profit = 450.0;
   min_profit = -1000.0;
   K_num_to_sl = 15;
   K_num_to_delete_pending = 30;
   magic1 = 1;
   magic2 = 2;
   magic3 = 3;
   magic4 = 4;
   count_A = 0;
   count_B = 0;
   A_reference = 0.0; 
   B_reference = 0.0;   
   comment = "Momentum";
  }
//+------------------------------------------------------------------+
//|  交易主函数函数
//+------------------------------------------------------------------+
void Momentum :: Trade_Main(string sym)
{
   CheckForOpen(sym); 
   TrailingStop_Magic(magic1, sym);
   TrailingStop_Magic(magic2, sym);
   TrailingStop_Magic(magic4, sym);
   Change_Depend_On_K(sym);
   CheckForClose(sym);
}
//+------------------------------------------------------------------+
//|  开仓函数
//+------------------------------------------------------------------+
void Momentum :: CheckForOpen(string sym)
{
    double  ask = MarketInfo(sym,MODE_ASK);
    double  bid = MarketInfo(sym,MODE_BID);
    double  point = MarketInfo(sym,MODE_POINT);
    double  open_0 = iOpen(sym,PERIOD_M15,0);
    double  open_1 = iOpen(sym,PERIOD_M15,1);
    double  close_1 = iClose(sym,PERIOD_M15,1);
  int ticket1,ticket2,ticket3,ticket4;
  if(A_reference!=open_0 && Count_Order(sym)<=8 && iMA(sym,PERIOD_M15,MA_period,0,MODE_EMA,PRICE_CLOSE,1)<close_1 && close_1-open_1>trend*10*point && iATR(sym,PERIOD_M15,Strategy_A_ATR_period,1)-iATR(sym,PERIOD_M15,Strategy_A_ATR_period,1+ATR_lookback_num)>0.0001*Strategy_A_ATR_increase)
     {
      double stop_loss=(close_1-open_1)*sl_level;
      if(stop_loss>max_sl*10*point)stop_loss=max_sl*10*point;
      if(stop_loss<min_sl*10*point)stop_loss=min_sl*10*point;
      ticket1=OrderSend(sym,OP_BUY,Lot,ask,30,ask-stop_loss,ask+take_profit*10*point,comment,magic1,0,Blue);
      ticket2=OrderSend(sym,OP_BUY,Lot,ask,30,ask-stop_loss,0,comment,magic2,0,Blue);
      count_A=0;
      A_reference=open_0;
     }
   if(B_reference!=open_0 && iMA(sym,PERIOD_M15,MA_period,0,MODE_EMA,PRICE_CLOSE,1)<close_1 && close_1-open_1>trend*10*point && iATR(sym,PERIOD_M15,Strategy_B_ATR_period,1)-iATR(sym,PERIOD_M15,Strategy_B_ATR_period,1+ATR_lookback_num)>0.0001*Strategy_B_ATR_increase)
     {

         ticket3=OrderSend(sym,OP_SELLSTOP,Lot,bid-pending_order_level*10*point,30,bid-pending_order_level*10*point+pending_order_sl*10*point,bid-pending_order_level*10*point-pending_order_tp*10*point,comment,magic3,0,Red);
         ticket4=OrderSend(sym,OP_SELLSTOP,Lot,bid-pending_order_level*10*point,30,bid-pending_order_level*10*point+pending_order_sl*10*point,0,comment,magic4,0,Red);
         count_B=0;
         B_reference=open_0;

     }
   if(A_reference!=open_0 && Count_Order(sym)<=8 && iMA(sym,15,MA_period,0,MODE_EMA,PRICE_CLOSE,1)>close_1 && open_1-close_1>trend*10*point && iATR(sym,15,Strategy_A_ATR_period,1)-iATR(sym,15,Strategy_A_ATR_period,1+ATR_lookback_num)>0.0001*Strategy_A_ATR_increase)
     {
      double stop_loss=(open_1-close_1)*sl_level;
      if(stop_loss>max_sl*10*point)stop_loss=max_sl*10*point;
      if(stop_loss<min_sl*10*point)stop_loss=min_sl*10*point;
      ticket1=OrderSend(sym,OP_SELL,Lot,bid,30,bid+stop_loss,bid-take_profit*10*point,comment,magic1,0,Red);
      ticket2=OrderSend(sym,OP_SELL,Lot,bid,30,bid+stop_loss,0,comment,magic2,0,Red);
      count_A=0;
      A_reference=open_0;
     }
   if(B_reference!=open_0 && iMA(sym,15,MA_period,0,MODE_EMA,PRICE_CLOSE,1)>close_1 && open_1-close_1>trend*10*point && iATR(sym,15,Strategy_B_ATR_period,1)-iATR(sym,15,Strategy_B_ATR_period,1+ATR_lookback_num)>0.0001*Strategy_B_ATR_increase)
     {
         ticket3=OrderSend(sym,OP_BUYSTOP,Lot,ask+pending_order_level*10*point,30,ask+pending_order_level*10*point-pending_order_sl*10*point,ask+pending_order_level*10*point+pending_order_tp*10*point,comment,magic3,0,Blue);
         ticket4=OrderSend(sym,OP_BUYSTOP,Lot,ask+pending_order_level*10*point,30,ask+pending_order_level*10*point-pending_order_sl*10*point,0,comment,magic4,0,Blue);
         count_B=0;
         B_reference=open_0;
     }
}

//+------------------------------------------------------------------+
//| 追踪止损函数
//+------------------------------------------------------------------+
void Momentum :: TrailingStop_Magic( int magic,string sym )
{
 int result;
 double  close_1 = iClose(sym,15,1);
 double  point = MarketInfo(sym,MODE_POINT);
 for (int cnt = OrdersTotal(); cnt >= 0; cnt--)
      {
       if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)==True)
         {  
           if(OrderSymbol()==sym)
              {       
                if(OrderType()==OP_SELL && OrderMagicNumber()==magic) 
                  {                                       
                   if((OrderOpenPrice()-close_1)>MarketInfo(sym,MODE_POINT)*First_B_TrailingStop*10 && OrderOpenPrice()<OrderStopLoss() && OrderStopLoss()!=OrderOpenPrice()-point*B_MinProfit*10)
                     {
                      result=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()-point*B_MinProfit*10,OrderTakeProfit(),0,Red);                                        
                     }
                   if((OrderStopLoss()-close_1)>MarketInfo(sym,MODE_POINT)*B_TrailingStop*10 && OrderStopLoss()!=close_1+point*B_TrailingStop*10)
                     {
                      result=OrderModify(OrderTicket(),OrderOpenPrice(),close_1+point*B_TrailingStop*10,OrderTakeProfit(),0,Red);                                        
                     }
                  }
                if(OrderType()==OP_BUY && OrderMagicNumber()==magic)
                  {                                        
                   if((close_1-OrderOpenPrice())>MarketInfo(sym,MODE_POINT)*First_B_TrailingStop*10 && OrderOpenPrice()>OrderStopLoss() && OrderStopLoss()!=OrderOpenPrice()+point*B_MinProfit*10)
                     {
                      result=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()+point*B_MinProfit*10,OrderTakeProfit(),0,Blue);                                        
                     }
                   if((close_1-OrderStopLoss())>MarketInfo(sym,MODE_POINT)*B_TrailingStop*10 && OrderStopLoss()!=close_1-point*B_TrailingStop*10)
                     {
                      result=OrderModify(OrderTicket(),OrderOpenPrice(),close_1-point*B_TrailingStop*10,OrderTakeProfit(),0,Blue);                                        
                     }
                  }  
            }         
         }
      }
}
//+------------------------------------------------------------------+
//|  平仓函数
//+------------------------------------------------------------------+
void Momentum :: CheckForClose(string sym)
{
 double total_profit=0;
 for(int cnt=OrdersTotal();cnt>=0;cnt--)
    {
     if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)==True)
       {
         if(OrderSymbol()==sym)
         {
           if(OrderMagicNumber()==magic1 || OrderMagicNumber()==magic2 || OrderMagicNumber()==magic3 || OrderMagicNumber()==magic4)
           total_profit=total_profit+OrderProfit()/OrderLots();
         }   
       }
    }
 if(total_profit>max_profit*10 || total_profit<min_profit*10) 
   {
    CloseOrder(sym);
   }     
}
//+------------------------------------------------------------------+
//|  单边平仓
//+------------------------------------------------------------------+
void Momentum :: CloseOrder(string sym)
{
  int result,total=OrdersTotal();
  for(int cnt=total-1;cnt>=0;cnt--)
  {
    if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
      {
        if(OrderSymbol()==sym)
        {
          if(OrderType() == OP_BUY && (OrderMagicNumber()==magic1 || OrderMagicNumber()==magic2 || OrderMagicNumber()==magic3 || OrderMagicNumber()==magic4))
            {
             result=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3);
            }
          if(OrderType() == OP_SELL && (OrderMagicNumber()==magic1 || OrderMagicNumber()==magic2 || OrderMagicNumber()==magic3 || OrderMagicNumber()==magic4))
            {
             result=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3);
            }
        } 
      }
  }
}
//+------------------------------------------------------------------+
//|  挂单删除
//+------------------------------------------------------------------+
void Momentum :: DeleteOrder(int ordertype, string sym)
{
  int result,total=OrdersTotal();
  for(int cnt=total-1;cnt>=0;cnt--)
  {
    if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
      {
        if(OrderSymbol()==sym)
        {
          if(OrderType() == ordertype && (OrderMagicNumber()==magic3 || OrderMagicNumber()==magic4))
            {
             result=OrderDelete(OrderTicket());
            }
        } 
      }
  }
}//+------------------------------------------------------------------+
//|  入场后N根K线调A策略止损、M根K线取消挂单
//+------------------------------------------------------------------+
void Momentum :: Change_Depend_On_K(string sym)
{
 double  open_0 = iOpen(sym,15,0);
 if(open_0!=A_reference)
   {
    count_A++;
    A_reference=open_0;
   }
 if(open_0!=B_reference)
   {
    count_B++;
    B_reference=open_0;
   }
 if(count_A==K_num_to_sl)
   {
    double former_high=iHigh(sym,0,iHighest(sym,15,MODE_HIGH,K_num_to_sl,1));
    double former_low=iLow(sym,0,iLowest(sym,15,MODE_LOW,K_num_to_sl,1));
    int result;
    for(int cnt=OrdersTotal();cnt>=0;cnt--)
       {
        if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)==True)
          { 
           if(OrderSymbol()==sym)
           {     
              if(OrderType()==OP_SELL && (OrderMagicNumber()==magic1 || OrderMagicNumber()==magic2) && OrderStopLoss()>former_high) 
                {                                        
                 result=OrderModify(OrderTicket(),OrderOpenPrice(),former_high,OrderTakeProfit(),0,Red);
                }
              if(OrderType()==OP_BUY && (OrderMagicNumber()==magic1 || OrderMagicNumber()==magic2) && OrderStopLoss()<former_low)
                {                                        
                 result=OrderModify(OrderTicket(),OrderOpenPrice(),former_low,OrderTakeProfit(),0,Blue);
                }  
            }          
          }
       }
   }
 if(count_B==K_num_to_delete_pending)
   {
    int result;
    for(int cnt=OrdersTotal();cnt>=0;cnt--)
       {
        if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)==True)
          {   
            if(OrderSymbol()==sym)
            {   
              if((OrderType()==OP_SELLSTOP || OrderType()==OP_BUYSTOP) && (OrderMagicNumber()==magic3 || OrderMagicNumber()==magic4)) 
                {                                        
                 result=OrderDelete(OrderTicket());
                }    
            }      
          }
       }
   }  
}
//+------------------------------------------------------------------+
//|  读挂单价格
//+------------------------------------------------------------------+
double Momentum :: Pending_Order_Op(int ordertype, string sym)
{
 double pending_op=0;
 if(ordertype==OP_SELLSTOP)pending_op=0;
 if(ordertype==OP_BUYSTOP)pending_op=99999;
 for(int cnt=OrdersTotal();cnt>=0;cnt--)
    {
     if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)==True)
       {  
        if(OrderSymbol()==sym)
        {    
           if(ordertype==OP_SELLSTOP && (OrderMagicNumber()==magic3 || OrderMagicNumber()==magic4)) 
             {                                        
              pending_op=OrderOpenPrice();
             } 
           if(ordertype==OP_BUYSTOP && (OrderMagicNumber()==magic3 || OrderMagicNumber()==magic4)) 
             {                                        
              pending_op=OrderOpenPrice();
             } 
         }       
       }
    }
 return pending_op;
}
//+------------------------------------------------------------------+
//|  统计策略持仓
//+------------------------------------------------------------------+
int Momentum :: Count_Order(string sym) 
{
 int result=0;
 int total=OrdersTotal();
 for(int cnt=total-1;cnt>=0;cnt--)
  {
    if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
      {
       if(OrderSymbol()==sym)
        {
          if(OrderMagicNumber()==magic1 || OrderMagicNumber()==magic2 || OrderMagicNumber()==magic3 || OrderMagicNumber()==magic4)result++;
        }
      }
  }
  return result;
}