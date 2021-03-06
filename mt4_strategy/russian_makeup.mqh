//+------------------------------------------------------------------+
//|                                               russian_makeup.mqh |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict
class Russian_Makeup
{
public:
   int Main_Trade(string sym);
   Russian_Makeup()
   {
   gd_108 = 0.01;
   Dinamic_lot = 0;
   lv_mode = FALSE;
   Level_stop = 0;
   sm_mode = FALSE;
   stop = 25;
   sn_mode = 50;
   sh_mode = 50;
   st_mode = TRUE;
   sk_mode = 2.0;
   sr_mode = TRUE; 
   gi_unused_220 = 0;
   g_magic_224 = 59999;
   gi_228 = 24;
   }
private:
   int   digits;
   double gd_108 ;
   double Dinamic_lot;  
   bool lv_mode ;
   int Level_stop ;
   bool sm_mode ;
   int stop ;
   int sn_mode ;
   int sh_mode;
   bool st_mode ;
   double sk_mode ;
   bool sr_mode ;
   int gi_unused_220 ;
   int g_magic_224;
   int gi_228 ;
   
   int g_pos_232;
   datetime g_time_236;
   string g_symbol_240;
   double g_ima_248;
   double g_ima_256;
   double gd_264;
   
   double setpoint();
   int OpenBuy(string a_symbol_0, double a_lots_8);
   int OpenSell(string a_symbol_0, double a_lots_8);
   void CloseBuy();
   void CloseSell();
   
   
      
  

}russian_makeup_strategy;

int Russian_Makeup::Main_Trade(string sym)
{  
   digits = int(MarketInfo(sym,MODE_DIGITS));
   double ld_0;
   double ld_8;
   double l_ord_open_price_16;
   double l_ord_open_price_24;
   double l_minlot_32;
   double l_marginrequired_40;
   double ld_48;
   int li_56;
   double ld_60;
   int l_count_68;
   bool li_72;
   bool li_76;
   int l_count_80;
   int l_count_84;
   int l_count_88;
   double ld_92;
   double l_minlot_100;
   double ld_108;
   double ld_116;
   double ld_124;
   double ld_132;
   int l_error_140;
   int li_144;
   string ls_148;
   string ls_156;
   string ls_164;
   string ls_172;
   
   
   HideTestIndicators(TRUE);
   g_ima_256 = iMA(sym, 0, 3, 0, MODE_LWMA, PRICE_MEDIAN, 0);
   g_ima_248 = iMA(sym, 0, 3, 0, MODE_LWMA, PRICE_MEDIAN, 1);
   HideTestIndicators(FALSE);
   if (IsTradeAllowed()) {
      if (iTime(sym,0,0) == g_time_236) return (0);
      g_time_236 = iTime(sym,0,0);
      g_symbol_240 = sym;
      ld_0 = NormalizeDouble(MarketInfo(sym,MODE_ASK), digits);
      ld_8 = NormalizeDouble(MarketInfo(sym,MODE_BID), digits);
      l_ord_open_price_16 = 0;
      l_ord_open_price_24 = 0;
      l_minlot_32 = MarketInfo(g_symbol_240, MODE_MINLOT);
      l_marginrequired_40 = MarketInfo(sym, MODE_MARGINREQUIRED);
      ld_48 = l_minlot_32;
      for (double ld_180 = 0; ld_48 < 1.0; ld_180++) ld_48 = 10.0 * ld_48;
      li_56 = OrdersTotal() - 1;
      if (lv_mode == TRUE) {
         if (AccountBalance() - AccountBalance() * Level_stop / 100.0 > AccountEquity()) {
            for (int l_pos_188 = li_56; l_pos_188 >= 0; l_pos_188--) {
               OrderSelect(l_pos_188, SELECT_BY_POS, MODE_TRADES);
               if (OrderMagicNumber() == g_magic_224 && OrderSymbol() == g_symbol_240) {
                  if (OrderType() == OP_BUY) CloseBuy();
                  if (OrderType() == OP_SELL) CloseSell();
               }
            }
         }
      }
      ld_60 = 0;
      l_count_68 = 0;
      li_72 = TRUE;
      li_76 = TRUE;
      for (int l_pos_188 = li_56; l_pos_188 >= 0; l_pos_188--) {
         OrderSelect(l_pos_188, SELECT_BY_POS, MODE_TRADES);
         if (OrderMagicNumber() == g_magic_224 && OrderSymbol() == g_symbol_240) l_count_68++;
      }
      if (l_count_68 >= sn_mode) li_72 = FALSE;
      l_count_80 = 0;
      l_count_84 = 0;
      l_count_88 = 0;
      ld_92 = gd_108;
      l_minlot_100 = gd_108;
      ld_108 = 0;
      ld_116 = 0;
      ld_124 = 0;
      for (int l_pos_188 = li_56; l_pos_188 >= 0; l_pos_188--) {
         OrderSelect(l_pos_188, SELECT_BY_POS, MODE_TRADES);
         if (OrderType() == OP_BUY && OrderMagicNumber() == g_magic_224 && OrderSymbol() == g_symbol_240) {
            ld_60 = OrderProfit() + OrderSwap() + ld_60;
            ld_108 += OrderLots();
            l_ord_open_price_16 = OrderOpenPrice();
            l_count_88++;
            if (MathAbs(l_ord_open_price_16 - ld_0) < sh_mode * setpoint()) l_count_80++;
            if (l_ord_open_price_16 - ld_0 > sh_mode * setpoint()) l_count_84++;
            if (ld_0 < l_ord_open_price_16) ld_116++;
            if (OrderLots() > ld_92) ld_92 = OrderLots();
         }
      }
      ld_108 /= 2.0;
      if (l_count_80 != 0) li_76 = FALSE;
      ld_92 = l_minlot_32;
      if (l_count_88 == 0) {
         l_minlot_100 = NormalizeDouble(AccountFreeMargin() * Dinamic_lot / 1000.0 / MarketInfo(sym, MODE_MARGINREQUIRED), 2);
         if (l_minlot_100 < l_minlot_32) l_minlot_100 = l_minlot_32;
      }
      if (l_count_84 == l_count_88 && l_count_88 != 0 && ld_116 == l_count_88) {
         if (st_mode == TRUE) {
            for (int l_pos_188 = li_56; l_pos_188 >= 0; l_pos_188--) {
               OrderSelect(l_pos_188, SELECT_BY_POS, MODE_TRADES);
               if (OrderType() == OP_BUY && OrderMagicNumber() == g_magic_224 && OrderSymbol() == g_symbol_240)
                  if (OrderLots() > ld_92) ld_92 = OrderLots();
            }
            l_minlot_100 = NormalizeDouble(ld_92 * sk_mode, 2);
         }
      }
      if (ld_60 >= l_marginrequired_40 * ld_108) {
         li_56 = OrdersTotal() - 1;
         for (int l_pos_188 = li_56; l_pos_188 >= 0; l_pos_188--) {
            OrderSelect(l_pos_188, SELECT_BY_POS, MODE_TRADES);
            RefreshRates();
            if (OrderType() == OP_BUY && OrderMagicNumber() == g_magic_224 && OrderSymbol() == g_symbol_240) {
               if (IsTesting() || IsOptimization()) OrderClose(OrderTicket(), OrderLots(), MarketInfo(g_symbol_240, MODE_BID), 3, Blue);
               else CloseBuy();
            }
         }
      }
      if (sr_mode == FALSE) gd_264 = iHighest(g_symbol_240, 0, MODE_HIGH, gi_228, 0);
      else gd_264 = iLowest(g_symbol_240, 0, MODE_LOW, gi_228, 0);
      if (gd_264 == 1.0 || gd_264 == 2.0 || gd_264 == 3.0 && g_ima_256 > g_ima_248 && li_72 == TRUE && li_76 == TRUE) {
         RefreshRates();
         if (IsTesting() || IsOptimization()) OrderSend(g_symbol_240, OP_BUY, l_minlot_100, NormalizeDouble(MarketInfo(g_symbol_240, MODE_ASK), Digits), 3, 0, 0, "Calypso ver 1.04", g_magic_224, 0, Blue);
         else OpenBuy(g_symbol_240, l_minlot_100);
      }
      ld_132 = 0;
      li_76 = TRUE;
      l_count_80 = 0;
      l_count_84 = 0;
      l_count_88 = 0;
      ld_92 = gd_108;
      l_minlot_100 = gd_108;
      ld_60 = 0;
      li_56 = OrdersTotal() - 1;
      for (int l_pos_188 = li_56; l_pos_188 >= 0; l_pos_188--) {
         OrderSelect(l_pos_188, SELECT_BY_POS, MODE_TRADES);
         if (OrderType() == OP_SELL && OrderMagicNumber() == g_magic_224 && OrderSymbol() == g_symbol_240) {
            ld_60 = OrderProfit() + OrderSwap() + ld_60;
            ld_132 += OrderLots();
            l_ord_open_price_24 = OrderOpenPrice();
            l_count_88++;
            if (MathAbs(l_ord_open_price_24 - ld_8) < sh_mode * setpoint()) l_count_80++;
            if (ld_8 - l_ord_open_price_24 > sh_mode * setpoint()) l_count_84++;
            if (ld_8 > l_ord_open_price_24) ld_124++;
            if (OrderLots() > ld_92) ld_92 = OrderLots();
         }
      }
      ld_132 /= 2.0;
      if (l_count_80 != 0) li_76 = FALSE;
      ld_92 = l_minlot_32;
      if (l_count_88 == 0) {
         l_minlot_100 = NormalizeDouble(AccountFreeMargin() * Dinamic_lot / 1000.0 / MarketInfo(sym, MODE_MARGINREQUIRED), 2);
         if (l_minlot_100 < l_minlot_32) l_minlot_100 = l_minlot_32;
      }
      if (l_count_84 == l_count_88 && l_count_88 != 0 && ld_124 == l_count_88) {
         if (st_mode == TRUE) {
            for (int l_pos_188 = li_56; l_pos_188 >= 0; l_pos_188--) {
               OrderSelect(l_pos_188, SELECT_BY_POS, MODE_TRADES);
               if (OrderType() == OP_SELL && OrderMagicNumber() == g_magic_224 && OrderSymbol() == g_symbol_240)
                  if (OrderLots() > ld_92) ld_92 = OrderLots();
            }
            l_minlot_100 = NormalizeDouble(ld_92 * sk_mode, 2);
         }
      }
      if (ld_60 >= l_marginrequired_40 * ld_132) {
         li_56 = OrdersTotal() - 1;
         for (int l_pos_188 = li_56; l_pos_188 >= 0; l_pos_188--) {
            OrderSelect(l_pos_188, SELECT_BY_POS, MODE_TRADES);
            RefreshRates();
            if (OrderType() == OP_SELL && OrderMagicNumber() == g_magic_224 && OrderSymbol() == g_symbol_240) {
               if (IsTesting() || IsOptimization()) OrderClose(OrderTicket(), OrderLots(), MarketInfo(g_symbol_240, MODE_ASK), 3, Fuchsia);
               else CloseSell();
            }
         }
      }
      if (sr_mode == FALSE) gd_264 = iLowest(g_symbol_240, 0, MODE_LOW, gi_228, 0);
      else gd_264 = iHighest(g_symbol_240, 0, MODE_HIGH, gi_228, 0);
      if (gd_264 == 1.0 || gd_264 == 2.0 || gd_264 == 3.0 && g_ima_256 < g_ima_248 && li_72 == TRUE && li_76 == TRUE) {
         RefreshRates();
         if (IsTesting() || IsOptimization()) OrderSend(g_symbol_240, OP_SELL, l_minlot_100, NormalizeDouble(MarketInfo(g_symbol_240, MODE_BID), Digits), 3, 0, 0, "Calypso ver 1.04", g_magic_224, 0, Fuchsia);
         else OpenSell(g_symbol_240, l_minlot_100);
      }
      g_symbol_240 = sym;
      l_error_140 = 0;
      if (sm_mode == TRUE) {
         if (stop < MarketInfo(g_symbol_240, MODE_STOPLEVEL)) stop = MarketInfo(g_symbol_240, MODE_STOPLEVEL);
         for (g_pos_232 = 0; g_pos_232 <= OrdersTotal() - 1; g_pos_232++) {
            OrderSelect(g_pos_232, SELECT_BY_POS, MODE_TRADES);
            if (OrderMagicNumber() == g_magic_224 && OrderStopLoss() == 0.0 && OrderSymbol() == sym) {
               while (li_144 <= 10) {
                  OrderModify(OrderTicket(), 0, MarketInfo(g_symbol_240, MODE_ASK) - stop * setpoint(), 0, 0, C'0x02,0x00,0x00');
                  l_error_140 = GetLastError();
                  if (l_error_140 == 0/* NO_ERROR */) {
                     Print("买成功");
                     break;
                  }
                  Print("我不能修改，买失败 " + GetLastError());
                  RefreshRates();
                  Sleep(5000);
                  li_144++;
               }
               Print("-----ERROR-----  我不能修改买订单");
               return (l_error_140);
            }
         }
      }
   } else Comment("交易禁止");


   return (0);


}

int Russian_Makeup::OpenBuy(string a_symbol_0, double a_lots_8) {
   int l_ticket_16;
   int l_slippage_20;
   int li_24 = 1;
   while (true) {
      l_slippage_20 = 1;
      l_ticket_16 = OrderSend(a_symbol_0, OP_BUY, a_lots_8, NormalizeDouble(MarketInfo(a_symbol_0, MODE_ASK), digits), l_slippage_20, 0, 0, "Calypso ver 1.04", g_magic_224, 0, Blue);
      if (l_ticket_16 <= 0) {
         Print("我无法打开？部落？购买。错误？", GetLastError());
         while (RefreshRates() == FALSE) Sleep(5000);
         li_24++;
         if (li_24 % 5 == 0) l_slippage_20++;
      } else {
         Print("部落？购买成功打开？");
         break;
      }
      if (li_24 != 11) continue;
      Comment("我无法打开？部落？买一个符号？", a_symbol_0, " 错误", GetLastError());
      break;
   }
   return (0);
}

int Russian_Makeup::OpenSell(string a_symbol_0, double a_lots_8) {
   int l_ticket_16;
   int l_slippage_20;
   int li_24 = 1;
   while (true) {
      l_slippage_20 = 1;
      l_ticket_16 = OrderSend(a_symbol_0, OP_SELL, a_lots_8, NormalizeDouble(MarketInfo(a_symbol_0, MODE_BID), digits), l_slippage_20, 0, 0, "Calypso ver 1.04", g_magic_224, 0, Fuchsia);
      if (l_ticket_16 <= 0) {
         Print("我无法打开？部落？卖。错误？", GetLastError());
         while (RefreshRates() == FALSE) Sleep(5000);
         li_24++;
         if (li_24 % 5 == 0) l_slippage_20++;
      } else {
         Print("部落？卖成功打开？");
         break;
      }
      if (li_24 != 11) continue;
      Comment("我无法打开？部落？卖的性格吗？", a_symbol_0, " 错误", GetLastError());
      break;
   }
   return (0);
}

void Russian_Makeup::CloseBuy() {
   int l_error_0;
   int l_count_4 = 0;
   while (true) {
      OrderClose(OrderTicket(), OrderLots(), NormalizeDouble(MarketInfo(OrderSymbol(), MODE_BID), digits), 2, White);
      l_error_0 = GetLastError();
      if (l_error_0 == 0/* NO_ERROR */) {
         Print("关闭购买。部落？“巴？成功关闭");
         return;
      }
      Print("我无法打开？部落？买一个符号？", Symbol(), " 错误", GetLastError());
      Sleep(500);
      RefreshRates();
      l_count_4++;
      if (l_count_4 <= 25) continue;
      break;
   }
   Alert("Order failed to CLOSE - See Journal for errors");
}

void Russian_Makeup::CloseSell() {
   int l_error_0;
   int l_count_4 = 0;
   while (true) {
      OrderClose(OrderTicket(), OrderLots(), NormalizeDouble(MarketInfo(OrderSymbol(), MODE_ASK), digits), 2, Red);
      l_error_0 = GetLastError();
      if (l_error_0 == 0/* NO_ERROR */) {
         Print("关闭卖。部落？卖成功关闭");
         return;
      }
      Print("我无法打开？部落？卖的性格吗？", Symbol(), " 错误", GetLastError());
      Sleep(500);
      RefreshRates();
      l_count_4++;
      if (l_count_4 <= 25) continue;
      break;
   }
   Alert("订单无法关闭 - 请看杂志的错误");
}

double Russian_Makeup:: setpoint() {
   double ld_ret_0;
   if (digits <= 3) ld_ret_0 = 0.01;
   else ld_ret_0 = 0.0001;
   return (ld_ret_0);
}