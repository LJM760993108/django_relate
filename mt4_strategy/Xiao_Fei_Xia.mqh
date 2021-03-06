
//+------------------------------------------------------------------+
//|                                                        赢龙小飞侠.mq4 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link		"https://www.mql5.com"
#property version	"1.00"
#property strict
#include <stdlib.mqh>

class xiao_fei_xia
{
public :
   void Trade_Main(string sym);
   int On_Init(string sym);
   xiao_fei_xia();
private :
   void GirdCalculate(string sym); 
   void IndicatorCalculate(string sym);
   bool IsTradeAble(string sym);
   int tradeSignalFiltered(string sym);
   bool tradeSignalBuy(string sym);
   bool tradeSignalSell(string sym);
   int FilterMA(string sym);
   int FilterOscillator(string sym);
   double MarginPercent();
   bool IsOrderExist(int orderType,string sym);
   int OrdersCount(int orderType,string sym);
   double LotsTotal(int orderType, string sym);
   void OpenOrder(int orderType, string sym);
   double ProfitTotal(int orderType,string sym);
   bool CloseAllOrder(int orderType,string sym );
   double LastOrderOpenPrice(int orderType,string sym);
   double LastOrderLots(int orderType,string sym);
   double FirstOrderLots(int orderType, string sym);
   double lyLotsFirst(string sym);
   void PrintInfoToChart(string sym );
   double lyLots(int orderType, string sym );
   
private:            
   //定义交易信号全局变量 
   int varTradeSignalFiltered;
   bool winwin,varIsOrderExistBuy;
   bool varIsOrderExistSell;
   int varOrdersCountBuy;
   int varOrdersCountSell;
   double varProfitTotalBuy;
   double varProfitTotalSell;
   
   //定义指标全局变量
   bool maHighTimeCrossBuy;
   bool maHighTimeCrossSell;
   bool maLowTimeCrossBuy;
   bool maLowTimeCrossSell;
   double maHighTimeLong0;
   double maHighTimeLong1;
   double maHighTimeShort0;
   double maHighTimeShort1;
   
   double maLowTimeLong0;
   double maLowTimeLong1;
   double maLowTimeShort0;
   double maLowTimeShort1;
   double varLastOrderLotsBuy;
   double varLastOrderLotsSell;
   string viewOrderCreate;
   string viewOrderAdd;
   string viewGird;
   
   //定义网格数组	
   double GirdFibo[];
   double GirdDrag[];
   double GirdWave[];   
   
   datetime TradeDay;
   string   ChartLabel[32];
   string   L1;                          //>>=====1.常规设置=====
   bool     AutoMM;                  //>>>  自动资金管理
   int      Risk;                      //>>>  资金使用比例
   int      LotMode;                   //>>>  追单模式 [1.固定手数;2.加倍开单;3.数列开单]
   double   Multiple;                    //>>>  翻倍倍率
   double   FixedLots;                //>>>  非自动模式固定手数
   double   Floot; 
   int      OrderOpenType;           //>>=====2.开仓 [1.瞬间开仓;2.均线金叉]=====
   ENUM_TIMEFRAMES MaHighTime;     //>>>  均线金叉 高时间图
   int      MaHighLongPeriod;             //>>>  均线金叉 高时间图 大周期
   int      MaHighShortPeriod;            //>>>  均线金叉 高时间图 小周期
   ENUM_TIMEFRAMES MaLowTime;   //>>>  均线金叉 低时间图
   int      MaLowLongPeriod;            //>>>  均线金叉 低时间图 大周期
   int      MaLowShortPeriod;            //>>>  均线金叉 低时间图 小周期
   bool     TwoWayMode;                //>>>  双向开仓模式
   bool     WinDouble;                  //>>>  一单盈利后加倍
   int      maxTradeAllow;                 //>>>  最大允许开单数量
   int      OrderAdd_DragpointDevMin;
   int      OrderAddType;                //>>>=====3.加仓 [1.固定网格;2.黄金网格;3.阻力网格;4.振幅网格]=====
   int      OrderAdd_FixGird_EachDevPips;   //>>>  固定网格 首次开单间距
   double   OrderAdd_FixGird_EachDevInc ;   //>>>  固定网格 每次开单间距增量
   int      OrderAdd_DragPointDevMin;         //>>>  阻力网格 阻力点分布最小值
   int      GirdBlurPips;                      //>>>  网格模糊控制插值
   
   int      OrderOpenFilter;            //>>>=====4.过滤器 [1.均线指标;2.振荡指标;3.同时启用]=====
   ENUM_TIMEFRAMES   Filter_Timeframe;      //>>>  均线指标 时间图
   int      Filter_Period;                        //>>>  均线指标 均线周期
   int      Filter_MA_MaOffPips;                     //>>>  均线指标 超偏移控制
   int      Filter_STO_UP;            //>>>  振荡指标 上轨
   int      Filter_STO_DW;            //>>>  振荡指标 下轨
   
   string   L5;                           //>>=====5.利润/风险控制=====
   int      EarnProfitPips;            //>>>  每次赢得利润点
   bool     CutStrategy;            //>>>  斩仓策略
   int      MaxDDAllow;                  //>>>  允许最大跌幅
   double   MarginPercentAllow;           //>>>  允许最小预付款比例
   bool     BreakEven;               //>>>  保本模式
   int      BreakEvenInt;               //>>>  多于几个订单启动保本模式
   double   lypoint;
   string   L6;                         //>>=====6.建仓时间控制[只控制建仓 不控制加仓]=====
   int      StartHour1;                //>>>  第一阶段 开始时间 小时
   int      StartMinute1;                //>>>  第一阶段 开始时间 分钟
   int      EndHour1;                  //>>>  第一阶段 结束时间 小时
   int      EndMinute1;               //>>>  第一阶段 结束时间 分钟
   int      StartHour2;                  //>>>  第二阶段 开始时间 小时
   int      StartMinute2;            //>>>  第二阶段 开始时间 分钟
   int      EndHour2;                  //>>>  第二阶段 结束时间 小时
   int      EndMinute2;                  //>>>  第二阶段 结束时间 分钟
   
   
   int      MagicNumber;
   string   EA_Name;
   double   lyPoint;
   double   DDBuffer;
   double   DDBuffer_Percent;             

} xiao_fei_xia_strategy;

xiao_fei_xia :: xiao_fei_xia(void)
{
   L1 = "";                          //>>=====1.常规设置=====
   AutoMM = false;                  //>>>  自动资金管理
   Risk = 10;                      //>>>  资金使用比例
   LotMode = 2;                   //>>>  追单模式 [1.固定手数;2.加倍开单;3.数列开单]
   Multiple =1.5;                    //>>>  翻倍倍率
   FixedLots = 0.01;                //>>>  非自动模式固定手数
   Floot = 0.005; 
   OrderOpenType = 1;           //>>=====2.开仓 [1.瞬间开仓;2.均线金叉]=====
   MaHighTime = PERIOD_H4;     //>>>  均线金叉 高时间图
   MaHighLongPeriod = 60;             //>>>  均线金叉 高时间图 大周期
   MaHighShortPeriod = 30;            //>>>  均线金叉 高时间图 小周期
   MaLowTime = PERIOD_M30;   //>>>  均线金叉 低时间图
   MaLowLongPeriod = 60;            //>>>  均线金叉 低时间图 大周期
   MaLowShortPeriod = 30;            //>>>  均线金叉 低时间图 小周期
   TwoWayMode = true;                //>>>  双向开仓模式
   WinDouble = true;                  //>>>  一单盈利后加倍
   maxTradeAllow = 15;                 //>>>  最大允许开单数量
   
   OrderAddType = 2;                //>>>=====3.加仓 [1.固定网格;2.黄金网格;3.阻力网格;4.振幅网格]=====
   OrderAdd_FixGird_EachDevPips = 10;   //>>>  固定网格 首次开单间距
   OrderAdd_FixGird_EachDevInc = 0.2;   //>>>  固定网格 每次开单间距增量
   OrderAdd_DragpointDevMin = 20;         //>>>  阻力网格 阻力点分布最小值
     
   GirdBlurPips = 3;                      //>>>  网格模糊控制插值
   
   OrderOpenFilter = 1;            //>>>=====4.过滤器 [1.均线指标;2.振荡指标;3.同时启用]=====
   Filter_Timeframe = PERIOD_H1;      //>>>  均线指标 时间图
   Filter_Period = 15;                        //>>>  均线指标 均线周期
   Filter_MA_MaOffPips = 60;                     //>>>  均线指标 超偏移控制
   Filter_STO_UP = 80;            //>>>  振荡指标 上轨
   Filter_STO_DW = 20;            //>>>  振荡指标 下轨
   
   L5="";                           //>>=====5.利润/风险控制=====
   EarnProfitPips = 30;            //>>>  每次赢得利润点
   CutStrategy = true;            //>>>  斩仓策略
   MaxDDAllow=50;                  //>>>  允许最大跌幅
   MarginPercentAllow=120;           //>>>  允许最小预付款比例
   BreakEven= true;               //>>>  保本模式
   BreakEvenInt = 5;               //>>>  多于几个订单启动保本模式
   
   L6 = "";                         //>>=====6.建仓时间控制[只控制建仓 不控制加仓]=====
   StartHour1 = 0;                //>>>  第一阶段 开始时间 小时
   StartMinute1 = 0;                //>>>  第一阶段 开始时间 分钟
   EndHour1 = 23;                  //>>>  第一阶段 结束时间 小时
   EndMinute1 = 59;               //>>>  第一阶段 结束时间 分钟
   StartHour2 = 0;                  //>>>  第二阶段 开始时间 小时
   StartMinute2 = 0;            //>>>  第二阶段 开始时间 分钟
   EndHour2 = 0;                  //>>>  第二阶段 结束时间 小时
   EndMinute2 = 0;                  //>>>  第二阶段 结束时间 分钟
   
   
   MagicNumber = 555555;
   EA_Name = "盈利小飞侠";
   lyPoint= 0.0001;
   DDBuffer  = 0;
   DDBuffer_Percent = 0;


}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void xiao_fei_xia :: GirdCalculate(string sym)
  {
   double  ask = MarketInfo(sym,MODE_ASK);
   double  bid = MarketInfo(sym,MODE_BID);
   double  point = MarketInfo(sym,MODE_POINT);
   int     digits = int(MarketInfo(sym,MODE_DIGITS));   
   
   
   double HighPricePrvDay= iHigh(sym,PERIOD_D1,1);
   double LowPricePrvDay = iLow(sym,PERIOD_D1,1);
   double WavePricePrvDay= HighPricePrvDay-LowPricePrvDay;
   int cnt;

   switch(OrderAddType)
     {
      case 1:
         viewGird="固定网格";
         break;
      case 2:
         viewGird="黄金网格";
         ArrayFree(GirdFibo);//斐波那契模式
         ArrayResize(GirdFibo,13);
         GirdFibo[0] = NormalizeDouble(LowPricePrvDay - WavePricePrvDay * 3.618,digits);
         GirdFibo[1] = NormalizeDouble(LowPricePrvDay - WavePricePrvDay * 2.618,digits);
         GirdFibo[2] = NormalizeDouble(LowPricePrvDay - WavePricePrvDay * 1.618,digits);
         GirdFibo[3] = NormalizeDouble(LowPricePrvDay - WavePricePrvDay * 0.618,digits);
         GirdFibo[4] = NormalizeDouble(LowPricePrvDay - WavePricePrvDay * 0.382,digits);
         GirdFibo[5] = NormalizeDouble(LowPricePrvDay,digits);
         GirdFibo[6] = NormalizeDouble(LowPricePrvDay + WavePricePrvDay * 0.382,digits);
         GirdFibo[7] = NormalizeDouble(LowPricePrvDay + WavePricePrvDay * 0.618,digits);
         GirdFibo[8] = NormalizeDouble(HighPricePrvDay,digits);
         GirdFibo[9] = NormalizeDouble(HighPricePrvDay + WavePricePrvDay * 1.382,digits);
         GirdFibo[10] = NormalizeDouble(HighPricePrvDay + WavePricePrvDay * 1.618,digits);
         GirdFibo[11] = NormalizeDouble(HighPricePrvDay + WavePricePrvDay * 2.618,digits);
         GirdFibo[12] = NormalizeDouble(HighPricePrvDay + WavePricePrvDay * 3.618,digits);

         for(int i=1; i<=ArraySize(GirdFibo); i++)
           {
            ObjectCreate(100+i,DoubleToStr(100+i,0),OBJ_HLINE,1,0,GirdFibo[i-1]);
            ObjectSetDouble(100+i,DoubleToStr(100+i,0),OBJPROP_PRICE,GirdFibo[i-1]);
           }
         break;
      case 3:
         viewGird="阻力点网格";
         ArrayFree(GirdDrag);//阻力点模式
         ArrayResize(GirdDrag,100);
         for(cnt=1; cnt<=15; cnt++)
           {
            GirdDrag[cnt*2-2] = iHigh(sym,PERIOD_D1,cnt);
            GirdDrag[cnt*2-1] = iLow(sym,PERIOD_D1,cnt);
           }
         for(cnt=0; cnt<ArraySize(GirdDrag); cnt++)
           {
            ArraySort(GirdDrag,WHOLE_ARRAY,0,MODE_DESCEND);
            int i=0;
            while(i<ArraySize(GirdDrag))
              {
               if(GirdDrag[i]-GirdDrag[i+1]<OrderAdd_DragpointDevMin*lypoint)
                 {
                  GirdDrag[i+1]=0;
                  break;
                 }
               i++;
              }
           }
         break;
      case 4:
         viewGird="振幅网格";
         ArrayFree(GirdWave);//波幅模式
         ArrayResize(GirdWave,23);
         GirdWave[0] = NormalizeDouble(LowPricePrvDay + WavePricePrvDay/3,digits);
         GirdWave[1] = NormalizeDouble(LowPricePrvDay + WavePricePrvDay*2/3,digits);
         GirdWave[2] = NormalizeDouble(HighPricePrvDay,digits);
         for(cnt=1; cnt<=10; cnt++)
           {
            GirdWave[3+cnt*2-2] = NormalizeDouble(HighPricePrvDay + WavePricePrvDay/3*cnt,digits);
            GirdWave[3+cnt*2-1] = NormalizeDouble(LowPricePrvDay - WavePricePrvDay/3*cnt,digits);
           }
         break;
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void xiao_fei_xia :: IndicatorCalculate(string sym )
  {
   if(OrderOpenType==2)
     {//计算均线指标 
      maHighTimeCrossBuy=false;
      maHighTimeCrossSell=false;
      maLowTimeCrossBuy=false;
      maLowTimeCrossSell=false;
      HideTestIndicators(false);
      maHighTimeLong0 = iMA(sym,MaHighTime,MaHighLongPeriod,0,MODE_SMA,PRICE_CLOSE,0);
      maHighTimeLong1 = iMA(sym,MaHighTime,MaHighLongPeriod,0,MODE_SMA,PRICE_CLOSE,1);
      maHighTimeShort0 = iMA(sym,MaHighTime,MaHighShortPeriod,0,MODE_SMA,PRICE_CLOSE,0);
      maHighTimeShort1 = iMA(sym,MaHighTime,MaHighShortPeriod,0,MODE_SMA,PRICE_CLOSE,1);

      maLowTimeLong0 = iMA(sym,MaLowTime,MaLowLongPeriod,0,MODE_SMA,PRICE_CLOSE,0);
      maLowTimeLong1 = iMA(sym,MaLowTime,MaLowLongPeriod,0,MODE_SMA,PRICE_CLOSE,1);
      maLowTimeShort0 = iMA(sym,MaLowTime,MaLowShortPeriod,0,MODE_SMA,PRICE_CLOSE,0);
      maLowTimeShort1 = iMA(sym,MaLowTime,MaLowShortPeriod,0,MODE_SMA,PRICE_CLOSE,1);

      if(maHighTimeShort0>maHighTimeLong0 && maHighTimeShort1<maHighTimeLong1) maHighTimeCrossBuy=true;
      if(maHighTimeShort0<maHighTimeLong0 && maHighTimeShort1>maHighTimeLong1) maHighTimeCrossSell=true;
      if(maLowTimeShort0>maLowTimeLong0 && maLowTimeShort1<maLowTimeLong1) maHighTimeCrossBuy=true;
      if(maLowTimeShort0<maLowTimeLong0 && maLowTimeShort1>maLowTimeLong1) maHighTimeCrossSell=true;
     }
  }
//+------------------------------------------------------------------+
//| Expert initialization function											   |
//+------------------------------------------------------------------+
int xiao_fei_xia :: On_Init(string sym)
  {
   lyLots(OP_BUY,sym);
   int k=30;
   varTradeSignalFiltered=tradeSignalFiltered(sym);
   varIsOrderExistBuy=IsOrderExist(OP_BUY,sym);
   varIsOrderExistSell=IsOrderExist(OP_SELL,sym);
   varOrdersCountBuy=OrdersCount(OP_BUY,sym);
   varOrdersCountSell= OrdersCount(OP_SELL,sym);
   varProfitTotalBuy = ProfitTotal(OP_BUY,sym);
   varProfitTotalSell= ProfitTotal(OP_SELL,sym);

   varLastOrderLotsBuy=LastOrderLots(OP_BUY,sym);
   varLastOrderLotsSell=LastOrderLots(OP_BUY,sym);
//---

   GirdCalculate(sym);
   IndicatorCalculate(sym);
  // PrintInfoToChart(sym);

   TradeDay=Day();

   switch(OrderOpenType)
     {
      case 1:
         viewOrderCreate="瞬间建仓";
         break;
      case 2:
         viewOrderCreate="均线金叉建仓";
         break;
     }
   switch(LotMode)
     {
      case 1:
         viewOrderAdd="固定手数";
         break;
      case 2:
         viewOrderAdd="双倍策略";
         break;
      case 3:
         viewOrderAdd="数列加仓";
         break;
     }
   return(INIT_SUCCEEDED);
  }

//+------------------------------------------------------------------+
//| Expert tick function															|
//+------------------------------------------------------------------+
void xiao_fei_xia :: Trade_Main(string sym)
  {
  
   double maxdd=NormalizeDouble(1 -(AccountEquity()/AccountBalance()),2);
   double AutoMMLots=NormalizeDouble(MathMax((AccountBalance() *Risk*0.01)/10000,0.01),2);

   if(TradeDay!=Day())
     {
      Sleep(1000);
      GirdCalculate(sym);
      TradeDay=Day();
     }

   varIsOrderExistBuy=IsOrderExist(OP_BUY,sym);
   varIsOrderExistSell=IsOrderExist(OP_SELL,sym);
   varOrdersCountBuy=OrdersCount(OP_BUY,sym);
   varOrdersCountSell= OrdersCount(OP_SELL,sym);
   varProfitTotalBuy = ProfitTotal(OP_BUY,sym);
   varProfitTotalSell= ProfitTotal(OP_SELL,sym);
   varLastOrderLotsBuy=LastOrderLots(OP_BUY,sym);
   varLastOrderLotsSell=LastOrderLots(OP_BUY,sym);
   varTradeSignalFiltered=tradeSignalFiltered(sym);

   IndicatorCalculate(sym);   //计算指标

   if(IsTradeAble(sym))
     {//开仓
      if(varTradeSignalFiltered==OP_SELL /*&& timeAllow*/)
        {
         OpenOrder(OP_SELL,sym);
        }
      if(varTradeSignalFiltered==OP_BUY/* && timeAllow*/)
        {
         OpenOrder(OP_BUY,sym);
        }
     }

   if(varIsOrderExistBuy)
     {//多单加仓/平仓/斩仓
      if(varProfitTotalBuy>=FirstOrderLots(OP_BUY,sym)*EarnProfitPips*10
         || (BreakEven && varOrdersCountBuy>=BreakEvenInt && varProfitTotalBuy>=0))
        {
         CloseAllOrder(OP_BUY,sym);
        }
      else if(varTradeSignalFiltered==OP_BUY
         &&  MarginPercent()>100                  //预付款比例大于100% 才能下单
         && varOrdersCountBuy<maxTradeAllow)
           {      //订单数量小于最大值 才能下单
            OpenOrder(OP_BUY,sym);
           }
         if(CutStrategy && (maxdd*100>MaxDDAllow || MarginPercent()<MarginPercentAllow))
           {//斩仓
            CloseAllOrder(OP_BUY,sym);
           }
     }
   if(varIsOrderExistSell)
     {//空单加仓/平仓/斩仓
      if(varProfitTotalSell>=FirstOrderLots(OP_SELL,sym)*EarnProfitPips*10
         || (BreakEven && varOrdersCountSell>=BreakEvenInt && varProfitTotalSell>=0))
        {
         CloseAllOrder(OP_SELL,sym);

        }
      else if(varTradeSignalFiltered==OP_SELL
         && MarginPercent() > 100                  //预付款比例大于100% 才能下单
         && varOrdersCountSell < maxTradeAllow)
           {   //订单数量小于最大值 才能下单
            OpenOrder(OP_SELL,sym);
           }
         if(CutStrategy && (maxdd*100>MaxDDAllow || MarginPercent()<MarginPercentAllow))
           {//斩仓
            CloseAllOrder(OP_SELL,sym);
           }
     }

   //PrintInfoToChart(sym); //输出信息到屏幕
  }
//+------------------------------------------------------------------+
bool xiao_fei_xia :: IsTradeAble(string sym)
  {
   if(TwoWayMode)
     {
      if(!IsOrderExist(OP_BUY,sym) || !IsOrderExist(OP_SELL,sym))
        {
         return(true);
        }
        } else {
      if(!IsOrderExist(OP_BUY,sym) && !IsOrderExist(OP_SELL,sym))
        {
         return(true);
        }
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int xiao_fei_xia :: tradeSignalFiltered(string sym)
  {
   bool varTradeSignalBuy=tradeSignalBuy(sym);
   bool varTradeSignalSell=tradeSignalSell(sym);
   int varFilterMA=FilterMA(sym);
   int varFilterOscillator=FilterOscillator(sym);

   if(varIsOrderExistBuy)
     {      //已有多单 不过滤
      if(varTradeSignalBuy) return(OP_BUY);
     }
   if(varIsOrderExistSell)
     {   //已有空单 不过滤
      if(varTradeSignalSell) return(OP_SELL);
     }
   switch(OrderOpenFilter)
     {
      case 1:   //1.均线指标
         if(varTradeSignalBuy==true && varFilterMA==OP_BUY && !varIsOrderExistBuy)
         return(OP_BUY);
         if(varTradeSignalSell==true && varFilterMA==OP_SELL && !varIsOrderExistSell)
            return(OP_SELL);
         break;
      case 2:   //2.振荡指标
         if(varTradeSignalBuy==true && varFilterOscillator==OP_BUY && !varIsOrderExistBuy)
         return(OP_BUY);
         if(varTradeSignalSell==true && varFilterOscillator==OP_SELL && !varIsOrderExistSell)
            return(OP_SELL);
         break;
      case 3:   //3.同时启用
         if(varTradeSignalBuy==true && varFilterMA==OP_BUY && varFilterOscillator==OP_BUY && !varIsOrderExistBuy)
         return(OP_BUY);
         if(varTradeSignalSell==true && varFilterMA==OP_SELL && varFilterOscillator==OP_SELL && !varIsOrderExistSell)
            return(OP_SELL);
         break;
     }
   return(9);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool xiao_fei_xia :: tradeSignalBuy(string sym)
  {
   double  ask = MarketInfo(sym,MODE_ASK);
   int     digits = int(MarketInfo(sym,MODE_DIGITS));   
   double varLastOrderOpenPriceBuy=LastOrderOpenPrice(OP_BUY,sym);
   int cnt;
   if(varIsOrderExistBuy==false)
     {      //首次开多单
      switch(OrderOpenType)
        {
         case 1:      //1.瞬间开仓
            return(true);
            break;
         case 2:      //2.均线金叉
            if(maHighTimeCrossBuy)
              {
               if(maLowTimeShort0>maLowTimeShort1)
                 {
                  return(true);
                 }
                 } else if(maLowTimeCrossBuy){
               return(true);
              }
            break;
        }
     }
   if(varIsOrderExistBuy==true)
     {      //多单加仓
      double PriceInc=NormalizeDouble(OrderAdd_FixGird_EachDevPips *(1+varOrdersCountBuy*OrderAdd_FixGird_EachDevInc)*lyPoint,digits);
      switch(OrderAddType)
        {
         case 1:      //1.固定网格
            if(ask<varLastOrderOpenPriceBuy-PriceInc)
              {
               return(true);
              }
            break;
         case 2:      //2.黄金网格
            for(cnt=0; cnt<ArraySize(GirdFibo); cnt++)
              {
               if(MathAbs(ask-GirdFibo[cnt])<GirdBlurPips*lyPoint
                  && ask<varLastOrderOpenPriceBuy-15*lyPoint)
                 {
                  return(true);
                 }
              }
            break;
         case 3:      //3.阻力网格
            for(cnt=0; cnt<ArraySize(GirdDrag); cnt++)
              {
               if(GirdDrag[cnt]<=0) break;
               if(MathAbs(ask-GirdDrag[cnt])<GirdBlurPips*lyPoint
                  && ask<varLastOrderOpenPriceBuy-15*lyPoint)
                 {
                  return(true);
                 }
              }
            break;
         case 4:      //4.振幅网格
            for(cnt=0; cnt<ArraySize(GirdWave); cnt++)
              {
               if(GirdWave[cnt]<=0) break;
               if(MathAbs(ask-GirdWave[cnt])<GirdBlurPips*lyPoint
                  && ask<varLastOrderOpenPriceBuy-15*lyPoint)
                 {
                  return(true);
                 }
              }
            break;
        }
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool xiao_fei_xia :: tradeSignalSell(string sym)
  {
   double  bid = MarketInfo(sym,MODE_BID);

   double varLastOrderOpenPriceSell=LastOrderOpenPrice(OP_SELL,sym);
   int cnt;
   if(varIsOrderExistSell==false)
     {      //首次开多单
      switch(OrderOpenType)
        {
         case 1:      //1.瞬间开仓
            return(true);
            break;
         case 2:      //2.均线金叉
            if(maHighTimeCrossSell)
              {
               if(maLowTimeShort0<maLowTimeShort1)
                 {
                  return(true);
                 }
                 } else if(maLowTimeCrossSell){
               return(true);
              }
            break;
        }
     }

   if(varIsOrderExistSell==true)
     {      //多单加仓
      double PriceInc=NormalizeDouble(OrderAdd_FixGird_EachDevPips *(1+varOrdersCountBuy*OrderAdd_FixGird_EachDevInc)*lyPoint,Digits);
      switch(OrderAddType)
        {
         case 1:      //1.固定网格
            if(bid>varLastOrderOpenPriceSell+PriceInc)
              {
               return(true);
              }
            break;
         case 2:      //2.黄金网格
            for(cnt=0; cnt<ArraySize(GirdFibo); cnt++)
              {
               if(MathAbs(bid-GirdFibo[cnt])<GirdBlurPips*lyPoint
                  && bid>varLastOrderOpenPriceSell+15*lyPoint)
                 {
                  return(true);
                 }
              }
            break;
         case 3:      //3.阻力网格
            for(cnt=0; cnt<ArraySize(GirdDrag); cnt++)
              {
               if(GirdDrag[cnt]<=0) break;
               if(MathAbs(bid-GirdDrag[cnt])<GirdBlurPips*lyPoint
                  && bid>varLastOrderOpenPriceSell+15*lyPoint)
                 {
                  return(true);
                 }
              }
            break;
         case 4:      //4.振幅网格
            for(cnt=0; cnt<ArraySize(GirdWave); cnt++)
              {
               if(GirdWave[cnt]<=0) break;
               if(MathAbs(bid-GirdWave[cnt])<GirdBlurPips*lyPoint
                  && bid>varLastOrderOpenPriceSell+15*lyPoint)
                 {
                  return(true);
                 }
              }
            break;
        }
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int xiao_fei_xia :: FilterMA(string sym)
  {
   double  bid = MarketInfo(sym,MODE_BID);
   HideTestIndicators(true);
   double MA=iMA(sym,Filter_Timeframe,Filter_Period,0,MODE_SMA,PRICE_CLOSE,0);

   if(bid>MA && bid<MA+Filter_MA_MaOffPips*lyPoint) return(OP_BUY); // 
   if(bid<MA && bid>MA-Filter_MA_MaOffPips*lyPoint) return(OP_SELL); //

   return(9);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int xiao_fei_xia :: FilterOscillator(string sym)
  {
  HideTestIndicators(true);
   double STO=iStochastic(sym,Filter_Timeframe,5,3,3,MODE_SMA,MODE_MAIN,PRICE_CLOSE,1);

   if(STO > Filter_STO_UP) return(OP_SELL);
   if(STO < Filter_STO_DW) return(OP_BUY);

   return(NULL);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double xiao_fei_xia :: MarginPercent()
  {
   if(AccountMargin()>0)
     {
      return(NormalizeDouble(AccountEquity()/AccountMargin()*100,2));
        } else {
      return(10000);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool xiao_fei_xia :: IsOrderExist(int orderType,string sym)
  {//判断订单是否存在
   for(int cnt=0; cnt<OrdersTotal(); cnt++)
     {
      if(!OrderSelect(cnt,SELECT_BY_POS))continue;
      if(OrderType()==orderType && OrderMagicNumber()==MagicNumber && OrderSymbol() == sym)
        {
         return(true);
        }
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int xiao_fei_xia :: OrdersCount(int orderType,string sym)
  {//返回指定类型订单数量
   int ordersTotal=0;
   for(int cnt=0; cnt<OrdersTotal(); cnt++)
     {
      if(!OrderSelect(cnt,SELECT_BY_POS))continue;
      if(OrderType()==orderType && OrderMagicNumber()==MagicNumber && OrderSymbol() == sym)
        {
         ordersTotal++;
        }
     }
   return(ordersTotal);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double xiao_fei_xia :: ProfitTotal(int orderType,string sym)
  {//返回指定类型订单盈利点数的和（以点数表示）
   double Profit=0;
   double ProfitSum=0;
   for(int cnt=0; cnt<OrdersTotal(); cnt++)
     {
      if(!OrderSelect(cnt,SELECT_BY_POS)) continue;
      if(OrderMagicNumber()==MagicNumber && OrderType()==orderType && OrderSymbol() == sym)
        {
         ProfitSum+=OrderProfit();
        }
     }
   return(ProfitSum);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double xiao_fei_xia :: LotsTotal(int orderType, string sym) 
  {
   double LotsSum=0;
   for(int cnt=0; cnt<OrdersTotal(); cnt++)
     {
      if(!OrderSelect(cnt,SELECT_BY_POS)) continue;
      if(OrderSymbol()==sym && OrderMagicNumber()==MagicNumber && OrderType()==orderType)
        {
         LotsSum+=OrderLots();
        }
     }
   return(LotsSum);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void xiao_fei_xia :: OpenOrder(int orderType, string sym)
  {//即时价格 指定类型 下单
   double  ask = MarketInfo(sym,MODE_ASK);
   double  bid = MarketInfo(sym,MODE_BID);
   int ticket,openClr=0;
   double openPrice=0;
   if(orderType==OP_BUY)
     {
      openPrice= ask;
      openClr=clrGreen;
     }
   if(orderType==OP_SELL)
     {
      openPrice= bid;
      openClr=clrRed;
     }
   ticket=OrderSend(sym,orderType,lyLots(orderType,sym),openPrice,5,0,0,EA_Name,MagicNumber,0,openClr);
   if(ticket) Print("OrderSend() Success..");
   else Print("OrderSend() error - ",ErrorDescription(GetLastError()));
   if(winwin) winwin=false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool xiao_fei_xia :: CloseAllOrder(int orderType,string sym )
  {
   double  ask = MarketInfo(sym,MODE_ASK);
   double  bid = MarketInfo(sym,MODE_BID);
   int ticket,ticketClose=0;
   int closeConfirmCnt=0;
   int closeOrderTicket[20];
   double closeProfit,closePrice=0;
   if(OrdersCount(orderType,sym)==1)
     {
      winwin=true;
        } else {
      winwin=false;
     }
   while(IsOrderExist(orderType,sym))
     {
      closeProfit =-99999;
      for(int cnt=0; cnt<OrdersTotal(); cnt++)
        {
         if(!OrderSelect(cnt,SELECT_BY_POS)) continue;
         if(OrderType()==orderType && OrderMagicNumber()==MagicNumber && OrderSymbol() == sym)
           {
            if(closeProfit<=OrderProfit())
              {
               closeProfit = OrderProfit();
               ticketClose = OrderTicket();
              }
           }
        }
      if(OrderSelect(ticketClose,SELECT_BY_TICKET))
        {
         if(orderType==OP_BUY && OrderSymbol() == sym)
           {
            closePrice=bid;
           }
         if(orderType==OP_SELL && OrderSymbol() == sym)
           {
            closePrice=ask;
           }
         ticket=OrderClose(OrderTicket(),OrderLots(),closePrice,5,clrGold);
         if(ticket) Print("OrderClose() Success..");
         else Print("OrderClose() error - ",ErrorDescription(GetLastError()));
        }
     }
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double xiao_fei_xia :: LastOrderOpenPrice(int orderType,string sym) 
  {
   datetime orderOpenTime=0;
   double orderPrice=0;
   for(int cnt=0; cnt<OrdersTotal(); cnt++)
     {
      if(!OrderSelect(cnt,SELECT_BY_POS)) continue;
      if(OrderType()==orderType && OrderMagicNumber()==MagicNumber && OrderSymbol() == sym)
        {
         if(orderOpenTime<OrderOpenTime())
           {
            orderOpenTime=OrderOpenTime();
            orderPrice=OrderOpenPrice();
           }
        }
     }
   return(orderPrice);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double xiao_fei_xia :: LastOrderLots(int orderType,string sym)
  {
   datetime orderOpenTime=0;
   double orderLots=0;
   for(int cnt=0; cnt<OrdersTotal(); cnt++)
     {
      if(!OrderSelect(cnt,SELECT_BY_POS)) continue;
      if(OrderType()==orderType && OrderMagicNumber()==MagicNumber && OrderSymbol() == sym)
        {
         if(orderOpenTime<OrderOpenTime())
           {
            orderOpenTime=OrderOpenTime();
            orderLots=OrderLots();
           }
        }
     }
   return(orderLots);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double xiao_fei_xia :: FirstOrderLots(int orderType, string sym) 
  {
   datetime orderOpenTimeFirst=D'2099.12.31 00:00:00';
   double orderLots=0;
   for(int cnt=0; cnt<OrdersTotal(); cnt++)
     {
      if(!OrderSelect(cnt,SELECT_BY_POS)) continue;
      if(OrderType()==orderType && OrderMagicNumber()==MagicNumber && OrderSymbol() == sym)
        {
         if(orderOpenTimeFirst>OrderOpenTime())
           {
            orderOpenTimeFirst=OrderOpenTime();
            orderLots=OrderLots();
           }
        }
     }
   return(orderLots);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double xiao_fei_xia :: lyLotsFirst(string sym)
  {
   double lots=0;
   if(AutoMM)
     {
      lots = (AccountBalance()* Risk * 0.01)/10000;
      lots = MathMax(lots,MarketInfo(sym,MODE_MINLOT));
      lots = NormalizeDouble(lots,2);
      return(lots);
        } else {
      return(FixedLots);
     }
   return(FixedLots);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double xiao_fei_xia :: lyLots(int orderType, string sym )
  {
   double lots=0;
   int FiboArray[20]={0,1,1,2,3,5,8,13,21,34,55,89,144,233,377,610,987,1597,2584,4181};
   int acc=1;
   if(AccountBalance()<1000) acc=1;
   else acc=2;
//varOrdersCountBuy
//varOrdersCountSell
   switch(LotMode)
     {
      case 1:   //固定手数
         return(FixedLots);
         break;
      case 2:   //加倍手数
         if(LastOrderLots(orderType,sym)==0)
           {
            lots=lyLotsFirst(sym);
            return(lots);
              } else {

            lots = LastOrderLots(orderType,sym) *Multiple;      
            lots = MathMax(lots,MarketInfo(sym,MODE_MINLOT)); 
            lots= NormalizeDouble(MathMax(lots+Floot,lots),2);  
            return(lots);
           }
         break;
      case 3:   //斐波那契数列
         if(WinDouble && winwin)
           {
            lots = NormalizeDouble(lyLotsFirst(sym) * acc * 2 * FiboArray[OrdersCount(orderType,sym) + 1],2);
            lots = MathMax(lots,MarketInfo(sym,MODE_MINLOT));
            return(lots);
              } else {
            lots = NormalizeDouble(lyLotsFirst(sym) * acc * FiboArray[OrdersCount(orderType,sym) + 1],2);
            lots = MathMax(lots,MarketInfo(sym,MODE_MINLOT));
            return(lots);
           }
         break;
     }
   return(FixedLots);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void xiao_fei_xia :: PrintInfoToChart(string sym )
  {

//账户类型
   string AccountType="";
   if(IsDemo()) AccountType="模拟账户";
   else AccountType="真实账户";

//是否允许EA交易
   string EAAllow="";
   if(IsExpertEnabled()) EAAllow="允许";
   else EAAllow="不允许";

//



   double DD=AccountBalance()-AccountEquity();
   double DD_Percent=NormalizeDouble((AccountBalance()-AccountEquity())/AccountBalance()*100,1);
   if(DD>DDBuffer) DDBuffer=DD;
   if(DD_Percent>DDBuffer_Percent) DDBuffer_Percent=DD_Percent;

   int orderCnt=0;
   double orderLots=0;
   for(int cnt=0; cnt<OrdersTotal(); cnt++)
     {
      if(OrderSelect(cnt,SELECT_BY_POS))
        {
         if(OrderSymbol()==sym && OrderMagicNumber()==MagicNumber && (OrderType()==OP_SELL || OrderType()==OP_BUY))
           {
            orderCnt++;
            orderLots+=OrderLots();
           }
        }
     }

   ChartLabel[0]= "";
   ChartLabel[1]= "赢龙小飞侠 EA Final";
   ChartLabel[2]= "点差：" + DoubleToStr(MarketInfo(sym, MODE_SPREAD) / 10, 2);
   ChartLabel[3]= "--------------------------------------------------------------";
   ChartLabel[4]= "建仓模式：" + viewOrderCreate;
   ChartLabel[5]= "加仓模式：" + viewOrderAdd;
   ChartLabel[6]= "加仓网格：" + viewGird;
   ChartLabel[7]= "--------------------------------------------------------------";
   ChartLabel[8]= "账户类型：" + AccountType;
   ChartLabel[9]= "允许EA交易：" + EAAllow;
   ChartLabel[10]= "账户名称：" + AccountName();
   ChartLabel[11]= "账户号码：" + DoubleToStr(AccountNumber(),0);
   ChartLabel[12]= "账户杠杆：" + DoubleToStr(AccountLeverage(), 0);
   ChartLabel[13]= "账户余额：" + DoubleToStr(AccountBalance(), 2);
   ChartLabel[14]= "账户净值：" + DoubleToStr(AccountEquity(), 2);
   ChartLabel[15]= "可用预付款：" + DoubleToStr(AccountFreeMargin(), 2);
   ChartLabel[16]= "已用预付款：" + DoubleToStr(AccountMargin(), 2);
   ChartLabel[17]= "最大跌幅(金额)：" + DoubleToStr(DDBuffer, 2);
   ChartLabel[18]= "最大跌幅(比例)：" + DoubleToStr(DDBuffer_Percent, 1) + "%";
   ChartLabel[19]= "--------------------------------------------------------------";
   ChartLabel[20]= "已开仓数量：" + DoubleToStr(orderCnt,0);
   ChartLabel[21]= "已开仓手数：" + DoubleToStr(orderLots, 2);
   ChartLabel[22]= "当前目标利润：" + DoubleToStr(EarnProfitPips * 10.5 * (FirstOrderLots(OP_SELL,sym) + FirstOrderLots(OP_BUY,sym)), 2);
   ChartLabel[23]= "当前订单利润：" + DoubleToStr(AccountProfit(), 2);
   ChartLabel[24]= "--------------------------------------------------------------";
   ChartLabel[25]= "Magic Number: " + DoubleToStr(MagicNumber,0);
   ChartLabel[26]= "--------------------------------------------------------------";
   ChartLabel[27]= "=外汇炒作杠杆高=";
   ChartLabel[28]= "=重仓操作风险大=";
   ChartLabel[29]= "=外汇市场多风雨=";
   ChartLabel[30]= "=定要轻仓控风险=";
   ChartLabel[31]= "--------------------------------------------------------------";
   for(int i=0; i<32; i++)
     {
      ObjectSetText(DoubleToStr(i,0),ChartLabel[i],10,"Arial",clrGold);
     }
  }
//+------------------------------------------------------------------+

