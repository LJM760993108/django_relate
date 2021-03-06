//+------------------------------------------------------------------+
//|                                                       global.mqh |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict

#include <config.mqh>
#include <SFE_Price_Action.mqh>
#include <Xiao_Fei_Xia.mqh>
#include <ForexHacked.mqh>
#include <Momentum_Strategy.mqh>
#include <pingfan_kj.mqh>



#define SYMBOL_EURUSD 0
#define SYMBOL_GBPUSD 1
#define SYMBOL_USDJPY 2
#define SYMBOL_USDCHF 3
#define SYMBOL_AUDUSD 4
#define SYMBOL_NZDUSD 5
#define SYMBOL_USDCAD 6
#define SYMBOL_AUDCAD 7
#define SYMBOL_AUDCHF 8
#define SYMBOL_AUDJPY 9
#define SYMBOL_AUDNZD 10
#define SYMBOL_EURGBP 11
#define SYMBOL_EURJPY 12
#define SYMBOL_EURCHF 13
#define SYMBOL_EURAUD 14
#define SYMBOL_EURNZD 15
#define SYMBOL_EURCAD 16
#define SYMBOL_GBPCHF 17
#define SYMBOL_GBPCAD 18
#define SYMBOL_GBPAUD 19
#define SYMBOL_GBPNZD 20
#define SYMBOL_NZDCHF 21
#define SYMBOL_CHFJPY 22
#define SYMBOL_CADCHF 23
#define SYMBOL_XAUUSD 24

struct GlobalMagicNum
{
public:
   GlobalMagicNum()
   {
      GF_MagicNumberBuy = 123;
      GF_MagicNumberSell = 321;
   }
   
public:
   int GF_MagicNumberBuy;   
   int GF_MagicNumberSell;
       
    
}g_global_magic_num;

Config cur_config(FILE_PATH);

//////////////////////////////////////////////////全局变量////////////////////////////////////////////////
//金贝帐户参数----------------------
double KirinCoinWrite;
string KirinCoinRemainder = "未登陆";
string kirinLogin;
string KirinIntegral;
//---
#define  OpenOrders 25 //黑马货币对数量
//面板参数----------------------------
//#define _PI    3.14
//#define _2PI   6.28
#define Magic  51866443

string Suffix=StringSubstr(Symbol(),6,0);
int    Suffix_len;
bool   Initialize = true;

extern int  x_dis = 15;                    //X轴位置
extern int  y_dis = 20;                    //Y轴位置

string Symbol_input[7]={"EURUSD","AUDUSD","AUDNZD","NZDUSD","NZDJPY","GBPUSD","EURGBP"};
bool   TradeSymbol[7]={false,false,false,false,false,false,false};





int    EaRun = 3;  
int    CurOrdersCount; 
int    HisOrdersCount; 
bool   CanObjectCreate;
bool   CanObjectCreate2;
bool   CanObjectCreate3;
bool   CanObjectCreate4;
string EA_state;
string RiskSwi="关闭";
string RiskChoose="按比例";
string Loading="程序加载中…………………………";

bool     RightPanelSwi=false; 
int      RightPagelNum=2;
  int    HisOrCur=0;
    int  HisOrdPage=0;
    int  CurOrdPage=0;
  int    OrdCalcuPageNum=1;

 string Para2="刷单型策略参数";    //刷单型策略参数---------------------------
 double MinLots=0.01;
 double LotExponent_s=1.5; 
 int    LotStep=100000;       
 int    start_time_s=0;
 int    close_time_s=24;
 int    Profit_s=35; 
 int    gi_104=13; 
 int    gi_116=13;
 int    GridStep=10; 
 int    Prosadka=700;
 int    Povtor=1;
 bool   MM_Auto=FALSE;

int    g_timeframe_140=PERIOD_M1;
int    g_timeframe_144=PERIOD_M1;
bool   gi_148=FALSE;
int    g_timeframe_152=PERIOD_M15;
double gd_108=1.0;
double gd_92=1.0;

int    MagicNumber=616463861;
int    gi_236=0;
int    g_ticket_240;
int    gi_244;
double g_lots_256;
double g_lots_264;
double g_lots_272;
double g_lots_280;
string g_comment_288;
datetime g_datetime_232=0; 
datetime g_datetime_228=0; 

extern string Para4="对冲型策略参数";  //对冲型策略参数
 string Symbol_01="EURUSD";
 string Symbol_02="GBPUSD";
extern double Lots_d=0.01;             //起始手数
extern int MaxStep=13;                 //最大加仓级数
 double Grid=15;
 double Doubling_rate=1.5;
 double TakeProfitPips_d=15;
 double TakeMoney=50;
 int Indicator_Period=50;
 int Count_00=5;
datetime time_01=0;
int MagicNumber_d=5165161;

 string Para5="趋势型策略参数";  //趋势型策略参数---------------------------
 double lot_q=0.01;
 double Risk=0.03;          //每1000美金下单手数
string comment_q="趋势型策略";

//突破微略参数-----------------------------------------
 bool   c1=true;
 int    period_short=5; 
 int    period_long=310;
 double limit=2.8; 
 int    period_sp=110; 
 double stop_q=0.19; 
 double profit_q=0.67; 
int     magic_a=122334; 

//指标策略参数-----------------------------------------
 bool   c2=true; 
 int    cci_period=13;
 int    ma_period_a = 77; 
 int    ma_period_b= 233; 
 int    ma_period_c= 566;
 int    cci_limit=158;
 int    ma_distance=180;
 double b_cha=5.1;
 double c_cha=1.3;
 int    price_cha=100;
 int    price_ma_cha=20;
 int    stop_b=850;
 int    profit_b=550;
 int    max_lot=2; 
int           magic_b=122338; 
datetime time_q;
double res_q=0.0;


//验证码参数------------------------------
string  line_1="----------MySQL standard definitions----------";
#define CLIENT_LONG_PASSWORD               1
#define CLIENT_FOUND_ROWS                  2
#define CLIENT_LONG_FLAG                   4
#define CLIENT_CONNECT_WITH_DB             8
#define CLIENT_NO_SCHEMA                  16
#define CLIENT_COMPRESS                   32
#define CLIENT_ODBC                       64
#define CLIENT_LOCAL_FILES               128
#define CLIENT_IGNORE_SPACE              256
#define CLIENT_PROTOCOL_41               512
#define CLIENT_INTERACTIVE              1024
#define CLIENT_SSL                      2048
#define CLIENT_IGNORE_SIGPIPE           4096
#define CLIENT_TRANSACTIONS             8192
#define CLIENT_RESERVED                16384
#define CLIENT_SECURE_CONNECTION       32768
#define CLIENT_MULTI_STATEMENTS        65536
#define CLIENT_MULTI_RESULTS          131072
#define CLIENT_PS_MULTI_RESULTS       262144

string line_2="----------MySQL Function----------";
#import "MT4ToMySQL.dll"
string cMySqlVersion ();
int    cGetMySqlErrorNumber(int pConnection);
int    cGetCursorErrorNumber(int pCursorID);
string cGetMySqlErrorDescription(int pConnection);
string cGetCursorErrorDescription(int pCursorID);
int    cMySqlConnect       (string pHost,
                            string pUser, 
                            string pPassword,
                            string pDatabase,
                            int    pPort, 
                            string pSocket,
                            int    pClientFlag);
void   cMySqlDisconnect    (int pConnection);
bool   cMySqlExecute       (int    pConnection,
                            string pQuery);
int    cMySqlCursorOpen    (int    pConnection,
                            string pQuery);
void   cMySqlCursorClose   (int pCursorID);
int    cMySqlCursorRows    (int pCursorID);
bool   cMySqlCursorFetchRow(int pCursorID);
string cMySqlGetRowField   (int    pCursorID,
                            int    pField);
string ReadIni             (string pFileName,
                            string pSection, 
                            string pKey); 
#import
string   line_3="----------Variable----------";
bool     Bool_Initit=true;
bool     ProgramSwitch=true;
string   EA_name="HKJQL-V3.05";
string   EA_name_ve="VAS";
string   UpdateWarnGet;

bool     SQLTrace = false;
datetime MySqlLastConnect=0;
int      MySqlErrorNumber; 
string   MySqlErrorDescription; 

string line_4="----------MySQL Server Configuration----------";
//string Host="120.55.61.24";
//string User="huike_kirin";
//string Password="hzhuike2018";
//string Database="kirin";
//string Database2="aaa";
//int    Port=3306;
//string Socket= "0";
//int    ClientFlag=0;
string Host;
string User;
string Password;
string Database;
string Database1;
string Database2;
string Database3;
string Database4;
string Database5;
//string Database2="aaa";
int    Port;
string Socket;
int    ClientFlag;
//bool     SQLTrace = false;
 //int MySqlErrorNumber;
 //string MySqlErrorDescription;
 //datetime MySqlLastConnect;
 
string line_5="----------MySQL Server Configuration----------";
//string fp_Host="119.29.196.239";
//string fp_User="root";
//string fp_Password="w987654";
//string fp_Database="ma_data";
////string fp_Database2="aaa";
//int    fp_Port=3306;
//string fp_Socket= "0";
//int    fp_ClientFlag=0;
string fp_Host;
string fp_User;
string fp_Password;
string fp_Database;
string fp_Database1;
string fp_Database2;
string fp_Database3;
string fp_Database4;
string fp_Database5;
//string Database2="aaa";
int    fp_Port;
string fp_Socket;
int    fp_ClientFlag;



//-------跟单 
    //string fo_Host="119.29.196.239";
    //string fo_User="root";
    //string fo_Password="w987654";
    //string fo_Database="test";
    //int    fo_Port=3306;
    //string fo_Socket= "0";
    //int    fo_ClientFlag=0;
int    fo_DB=-1;  
string fo_Host;
string fo_User;
string fo_Password;
string fo_Database;
string fo_Database1;
string fo_Database2;
string fo_Database3;
string fo_Database4;
string fo_Database5;
//string Database2="aaa";
int    fo_Port;
string fo_Socket;
int    fo_ClientFlag;
//--------物件名称---------------------------------
string   obj_name_start="_000";
//---
string   obj_name_initial="0_";
string   obj_name_main="1_";
string   obj_name_extend="2_";
//---

/*
string   obj_name_function_0="a_";
string   obj_name_function_1="b_";
string   obj_name_function_2="c_";
string   obj_name_function_3="d_";
string   obj_name_function_4="e_";
string   obj_name_function_5="f_";
string   obj_name_function_6="g_";
string   obj_name_function_7="h_";
string   obj_name_function_8="i_";
*/


//int ac_num=0;
/*
#define ac_Sort              0
#define ac_id                1
#define ac_login             2
#define ac_trade_mode        3
#define ac_leverage          4
#define ac_balance           5
#define ac_profit            6
#define ac_equity            7
#define ac_margin            8
#define ac_margin_free       9
#define ac_margin_level      10
#define ac_create_tab_time   11
#define ac_timecurren        12
#define ac_sym_choose        13
#define ac_his_sql_num       14
#define ac_pos_sql_num       15
#define ac_signal_display    16
#define ac_all_profit    17
#define ac_month_profit    18
#define ac_Signal_grade    19
#define ac_ratio    20
*/

datetime fo_timelocal=0;
datetime fo_timelocal_sig=0;
datetime time_300=0;
extern  int update_ac=2;
int sing_page=0;
int page=0;
int page_new=0;
int table_rank=0;
#define  ac_tab_num 21
double   ac_info[][ac_tab_num];
string  fo_ordertotal[][12];
int ac_login_num=0;
int Statistics_total=0;
int main_panel_choose=-1;
int mp_magic=45625;
//double ac_information[][ac_tab_num];
int line_hi=17;  
#define ESMT 100 //定时器


//黑马系统-----------------------------------------------------------------------------------------------|
#define  s_0                    0  //货币对名称(不能改)
#define  Profit_0               1  //获利(不能改)
#define  Gallon_coefficient_0   2  //加仓系数(不能改)
#define  Opening_distance_0     3  //加仓间距(不能改)
#define  Position_0             4  //起始仓位(不能改)
#define  profit_price_0         5  //起始仓位(不能改)
#define  symbol_conut           100  
#define  timeframe PERIOD_M1

//-----------------------------货币名称--获利金额--加仓系数--加仓间距--起始仓位--获利点值
string Sym[symbol_conut][6]= { {"EURUSD",  "35",    "1.2",     "30",    "0.01",    "50"},
                               {"GBPUSD",  "35",    "1.2",     "30",    "0.01",    "50"},
                               {"USDJPY",  "30",    "1.2",     "30",    "0.01",    "50"},
                               {"USDCHF",  "25",    "1.2",     "30",    "0.01",    "50"},
                               {"AUDUSD",  "20",    "1.2",     "30",    "0.01",    "50"},
                               {"NZDUSD",  "30",    "1.2",     "30",    "0.01",    "50"},
                               {"USDCAD",  "35",    "1.2",     "30",    "0.01",    "50"},
                               {"AUDCAD",  "25",    "1.2",     "30",    "0.01",    "50"},
                               {"AUDCHF",  "20",    "1.2",     "30",    "0.01",    "40"},
                               {"AUDJPY",  "20",    "1.2",     "30",    "0.01",    "50"},
                               {"AUDNZD",  "25",    "1.2",     "30",    "0.01",    "50"},
                               {"EURGBP",  "25",    "1.2",     "30",    "0.01",    "50"},
                               {"EURJPY",  "35",    "1.2",     "30",    "0.01",    "45"},
                               {"EURCHF",  "35",    "1.2",     "30",    "0.01",    "50"},
                               {"EURAUD",  "35",    "1.2",     "30",    "0.01",    "50"},
                               {"EURNZD",  "35",    "1.2",     "30",    "0.01",    "50"},
                               {"EURCAD",  "35",    "1.2",     "30",    "0.01",    "50"},
                               {"GBPCHF",  "20",    "1.2",     "30",    "0.01",    "50"},
                               {"GBPCAD",  "20",    "1.2",     "30",    "0.01",    "50"},
                               {"GBPAUD",  "20",    "1.2",     "30",    "0.01",    "50"},
                               {"GBPNZD",  "20",    "1.2",     "30",    "0.01",    "50"},
                               {"NZDCHF",  "20",    "1.2",     "30",    "0.01",    "50"},
                               {"CHFJPY",  "35",    "1.2",     "30",    "0.01",    "50"},
                               {"CADCHF",  "35",    "1.2",     "30",    "0.01",    "50"},
                               {"XAUUSD",  "20",    "1.2",     "30",    "0.01",    "35"}
                                };
extern string Para6="黑马系统参数";  //黑马系统参数---------------------------
int Sym_Count=0;                        //货币对显示数量
int max_order_quantity=150;             //单边最大订单数。
double max_loss_1=1000;                 //止损（元）
 //int OpenOrders=OpenOrders; 
 string GridStep_bh="50";         //加仓
int   MagicNumber_h=82085888;
datetime    iTime_0[symbol_conut];
double      Notes[symbol_conut];
bool BLInitial=true;
int  BLpressreturn=0;


  
//+------------------------------------------------------------------+
//|高富帅                                                                  |
//+------------------------------------------------------------------+
//=============================================================================

//-----------------------------货币名称--获利金额--加仓系数--加仓间距--起始仓位--获利点值
string GFS_Sym[symbol_conut][6]= { {"EURUSD",  "35",    "1.2",     "30",    "0.01",    "50"},
                               {"GBPUSD",  "35",    "1.2",     "30",    "0.01",    "50"},
                               {"USDJPY",  "30",    "1.2",     "30",    "0.01",    "50"},
                               {"USDCHF",  "25",    "1.2",     "30",    "0.01",    "50"},
                               {"AUDUSD",  "20",    "1.2",     "30",    "0.01",    "50"},
                               {"NZDUSD",  "30",    "1.2",     "30",    "0.01",    "50"},
                               {"USDCAD",  "35",    "1.2",     "30",    "0.01",    "50"},
                               {"AUDCAD",  "25",    "1.2",     "30",    "0.01",    "50"},
                               {"AUDCHF",  "20",    "1.2",     "30",    "0.01",    "40"},
                               {"AUDJPY",  "20",    "1.2",     "30",    "0.01",    "50"},
                               {"AUDNZD",  "25",    "1.2",     "30",    "0.01",    "50"},
                               {"EURGBP",  "25",    "1.2",     "30",    "0.01",    "50"},
                               {"EURJPY",  "35",    "1.2",     "30",    "0.01",    "45"},
                               {"EURCHF",  "35",    "1.2",     "30",    "0.01",    "50"},
                               {"EURAUD",  "35",    "1.2",     "30",    "0.01",    "50"},
                               {"EURNZD",  "35",    "1.2",     "30",    "0.01",    "50"},
                               {"EURCAD",  "35",    "1.2",     "30",    "0.01",    "50"},
                               {"GBPCHF",  "20",    "1.2",     "30",    "0.01",    "50"},
                               {"GBPCAD",  "20",    "1.2",     "30",    "0.01",    "50"},
                               {"GBPAUD",  "20",    "1.2",     "30",    "0.01",    "50"},
                               {"GBPNZD",  "20",    "1.2",     "30",    "0.01",    "50"},
                               {"NZDCHF",  "20",    "1.2",     "30",    "0.01",    "50"},
                               {"CHFJPY",  "35",    "1.2",     "30",    "0.01",    "50"},
                               {"CADCHF",  "35",    "1.2",     "30",    "0.01",    "50"},
                               {"XAUUSD",  "20",    "1.2",     "30",    "0.01",    "35"} };
                               


//******************-----------------------------------------------------------------------------------------|
//******************-----------------------------------------------------------------------------------------|
//******************-----------------------------------------------------------------------------------------|
//******************-----------------------------------------------------------------------------------------|
//******************-----------------------------------------------------------------------------------------|
//******************-----------------------------------------------------------------------------------------|
//******************-----------------------------------------------------------------------------------------|

//金贝帐户验证-----------------------------------------------------------------------------------------|
    string txtstr;
    
    
/*string OrIn_symbol[];
string OrIn_type[];
string OrIn_lots[];
string OrIn_opentime[];
string OrIn_closetime[];
string OrIn_openprice[];
string OrIn_closeprice[];
string OrIn_sl[];
string OrIn_tp[];
string OrIn_swap[];
string OrIn_pips[];
string OrIn_profit[];
*/
  
/*
struct HisInfo
  {
    string date; 
    int    CountAll;
    int    CountBuy;
    int    CountSell;
    double LotsAll;
    double LotsBuy;
    double LotsSell;
    double Swap;
    double Commission;
    double Profit;
    double ProfitPercent;
    double Banlance; 
  }info[];
int HisInfoCount=0;
int HisInfoPage=0;
*/
  
#import  "Wininet.dll"
int InternetOpenW(string,int,string,string,int);
int InternetConnectW(int,string,int,string,string,int,int,int);
int HttpOpenRequestW(int,string,string,int,string,int,string,int);
int InternetOpenUrlW(int,string,string,int,int,int);
int InternetReadFile(int,uchar &sBuffer[],int,int &OneInt[]);
int InternetCloseHandle(int);
#import

/*string RiskLable_1="5";
string RiskLable_2="8";
string RiskLable_3="10";
string RiskLable_4="15";
string RiskLable_5="20";
color  RiskClr_1=clrDarkGray;
color  RiskClr_2=clrDarkGray;
color  RiskClr_3=clrDarkGray;
color  RiskClr_4=clrDarkGray;
color  RiskClr_5=clrDarkGray;
double RiskRate=0.0;
double RiskRate_p=0.0;
double RiskMoney=0.0;
double RiskMoney_p=0.0;

bool   NewsReadSwi=true;
*/
int    NewsLines=0;


struct NewsStr
  {
    string strTime;
    string strNews;
    string strImportance;
  }newsstr[25];
  
string   sym_[];
#define symbol_count 9  
string symbol_[symbol_count]={"GBP","USD","EUR","AUD","CAD","JPY","CHF","NZD","SGD"};
     string Ma_tab_name="Ma";
extern int Ma_Profit=600;
int his_total=0;
extern int Ma_Magic=54615;
extern double start_lot_zg=0.01;
   int Sym_Count_zg=0;
 double  Pos_data[][4];
 double  His_profit[];
int his_start_ticket=0;
long chart_id_zg[];
double trend_price[];
double trend_check=0;
string  trend_line_name="trendline";
int Use_of_license=1;
bool trade_perimt=false;
datetime uptime=TimeCurrent();
datetime trend_up_time=0;
#define  madata_trade      0
#define  madata_buy_lots   1
#define  madata_sell_lots  2
#define  madata_profit     3

   string acc_tab_name="SignalSourceAcc";
   string acc_tab_Customer="CustomerAcc";
int signal_num=0;   
   #define mysql_tab_num   19 
   string acc_table[mysql_tab_num][2]={
                                        " id",           " int(10) PRIMARY KEY AUTO_INCREMENT", 
                                        //" ACC_NAME",    " VARCHAR(25)", //位置不可改变
                                        " LOGIN",       " VARCHAR(25)", //位置不可改变
                                        " SERVER",      " VARCHAR(25)", //位置不可改变
                                        " CURRENCY",      " VARCHAR(25)", 
                                        " COMPANY",          " VARCHAR(50)", 
                                        " TRADE_MODE",     " VARCHAR(25)", 
                                        " LEVERAGE",           " VARCHAR(25)", 
                                        " BALANCE",           " VARCHAR(25)", 
                                        " PROFIT",      " VARCHAR(25)", 
                                        " EQUITY",     " VARCHAR(25)", 
                                        " MARGIN",       " VARCHAR(25)", 
                                        " MARGIN_FREE",      " VARCHAR(25)", 
                                        " MARGIN_LEVEL",        " VARCHAR(25)", 
                                        " CREATE_TAB_TIME",        " VARCHAR(25)", 
                                        " TimeCurrent",      " VARCHAR(25)",
                                        " Stop_loss_rate",      " VARCHAR(25) ",
                                        " Signal_Permit",      " VARCHAR(25) ",
                                        " Use_of_license",      " VARCHAR(25) ",
                                        " Remarks",      " VARCHAR(25)"
                                         
                                       };  
                                       
//金贝帐户金币读取与写入-------------------------------------------------------------------------------|
#import  "OpenURL.dll"
void   OpenURL_(string url);
string GetPath_(string url);
#import
string KirinAccountNumber=NULL;
string KirinAccountPassword=NULL;

#include "\md5hash.mqh"
CMD5Hash md5;

string fp_login="订单汇总";
   
   
string table_information[100][7];

  
datetime IntegerToTime(int num,int typ=0)
  {
    datetime retime=0;
    string str_y=(string)TimeYear(num);
    string str_m=(string)TimeMonth(num);
    string str_d=(string)TimeDay(num);
    string str_h=(string)TimeHour(num);
    string str_mi=(string)TimeMinute(num);
    string str_s=(string)TimeSeconds(num);
    
    if(typ==0)
      retime=StrToTime(str_y+"."+str_m+"."+str_d+" "+str_h+":"+str_mi);
      
    if(typ==1)
      retime=StrToTime(str_y+"."+str_m+"."+str_d);
      
    return(retime);
  }



struct BlaHorPara
  {
    int OrdCount;
    int OrdCount_b;
    int OrdCount_s;
    double OrdLots;
    double OrdLots_b;
    double OrdLots_s;
    double OrdProfit;
  }blapara[OpenOrders];
double hStartLots[OpenOrders];
double hStoploss[OpenOrders];
int    hMaxOrd[OpenOrders];
bool   hSwitch[OpenOrders];
color  hButColor[OpenOrders];
bool   CheckOpen[OpenOrders];

int ESMT_time=0;

bool  Strategy_s[4]={false,false,false,false};
bool  Strategy_w[4]={false,false,false,false};
bool  Strategy_d[4]={false,false,false,false};
bool  Strategy_q[4]={false,false,false,false};
bool  Strategy_m[4]={false,false,false,false};
color clr_l_s[4]={C'70,190,250',C'70,190,250',C'70,190,250',C'70,190,250'};
color clr_l_w[4]={C'70,190,250',C'70,190,250',C'70,190,250',C'70,190,250'};
color clr_l_d[4]={C'70,190,250',C'70,190,250',C'70,190,250',C'70,190,250'};
color clr_l_q[4]={C'70,190,250',C'70,190,250',C'70,190,250',C'70,190,250'};
color clr_l_m[4]={C'70,190,250',C'70,190,250',C'70,190,250',C'70,190,250'};
color clr_b_s[4]={C'5,33,56',C'5,33,56',C'5,33,56',C'5,33,56'};
color clr_b_w[4]={C'5,33,56',C'5,33,56',C'5,33,56',C'5,33,56'};
color clr_b_d[4]={C'5,33,56',C'5,33,56',C'5,33,56',C'5,33,56'};
color clr_b_q[4]={C'5,33,56',C'5,33,56',C'5,33,56',C'5,33,56'};
color clr_b_m[4]={C'5,33,56',C'5,33,56',C'5,33,56',C'5,33,56'};



//****************************************************************************************
//****************************************************************************************
//****************************************************************************************
//****************************************************************************************
//+------------------------------------------------------------------+
//|帐户信息                                                                  |
//+------------------------------------------------------------------+
struct ACC_INFO
   { 
     string NAME;                               //账户名
     string SERVER;                             //交易服务器名称
     string CURRENCY;                           //账户货币
     string COMPANY;                            //提供账户的公司名称
     //---
     long LONG;                                 //账号
     long TRADE_MODE;                           //0=模拟， 1=竞赛， 2=实盘
     long LEVERAGE;                             //账户杠杆
     long LIMIT_ORDERS;                         // 订单最大允许量
     long  MARGIN_SO_MODE;                      //建立最少使用保证金
     bool TRADE_ALLOWED;                        //允许活期账户交易
     bool TRADE_EXPERT;                         //允许EA交易
     double MINLOT;                             //下单最小手数
     double MAXLOT;                             //下单最大手数
     double STOPLEVEL;                          //平台限制：允许的最小止损止盈和当前价格距离点数
     //---
     double  BALANCE;                           //账户结余
     double  CREDIT;                            //存入货币时账户信用
     double  PROFIT;                            //账户当前利润
     double  EQUITY;                            //净值
     double  MARGIN;                            //已用预付款
     double  MARGIN_FREE;                       //账户可用保证金
     double  MARGIN_LEVEL;                      //当前账户预付款比例（%）
     double  MARGIN_SO_CALL;                    //保证金调用水平%
     double  MARGIN_SO_SO;                      //保证金停用水平%
     double  MARGIN_INITIAL;                    //初始预付款。账户上保留的金额需要涵盖所有挂单的预付款
     double  MARGIN_MAINTENANCE;                //维持预付款。账户上保留的最小净值需要涵盖所有持仓的最小金额
     double  ASSETS;                            //账户的活动资本
     double  LIABILITIES;                       //账户的流动负债
     double  COMMISSION_BLOCKED;                //账户的当前锁定手续费金额
     double  All_lots;                          //帐户总手数
     double  All_profit;                          //帐户总手数
//---帐户信息读取
   //~ACC_INFO(){Print("This is the end");}
   }MN_ACC_INFO; 
void  MN_ACC_INFO(){  
      MN_ACC_INFO.NAME= AccountInfoString(ACCOUNT_NAME);
      MN_ACC_INFO.SERVER= AccountInfoString(ACCOUNT_SERVER);
      MN_ACC_INFO.CURRENCY= AccountInfoString(ACCOUNT_CURRENCY);
      MN_ACC_INFO.COMPANY= AccountInfoString(ACCOUNT_COMPANY);
      //---
      MN_ACC_INFO.LONG= AccountInfoInteger(ACCOUNT_LOGIN); 
      MN_ACC_INFO.TRADE_MODE=AccountInfoInteger(ACCOUNT_TRADE_MODE); //??
      MN_ACC_INFO.LEVERAGE= AccountInfoInteger(ACCOUNT_LEVERAGE);
      MN_ACC_INFO.LIMIT_ORDERS= AccountInfoInteger(ACCOUNT_LIMIT_ORDERS);
      MN_ACC_INFO.MARGIN_SO_MODE= AccountInfoInteger(ACCOUNT_MARGIN_SO_MODE);//??
      MN_ACC_INFO.TRADE_ALLOWED= AccountInfoInteger(ACCOUNT_TRADE_ALLOWED);
      MN_ACC_INFO.TRADE_EXPERT= AccountInfoInteger(ACCOUNT_TRADE_EXPERT);
      MN_ACC_INFO.MINLOT=MarketInfo(Symbol(),MODE_MINLOT);
      MN_ACC_INFO.MAXLOT=MarketInfo(Symbol(),MODE_MAXLOT);
      MN_ACC_INFO.STOPLEVEL=MarketInfo(Symbol(),MODE_STOPLEVEL);
      //---
      MN_ACC_INFO.BALANCE= AccountInfoDouble(ACCOUNT_BALANCE);
      MN_ACC_INFO.CREDIT= AccountInfoDouble(ACCOUNT_CREDIT);
      MN_ACC_INFO.PROFIT= AccountInfoDouble(ACCOUNT_PROFIT);
      MN_ACC_INFO.EQUITY= AccountInfoDouble(ACCOUNT_EQUITY);
      MN_ACC_INFO.MARGIN= AccountInfoDouble(ACCOUNT_MARGIN);
      MN_ACC_INFO.MARGIN_FREE= AccountInfoDouble(ACCOUNT_MARGIN_FREE);
      MN_ACC_INFO.MARGIN_LEVEL= AccountInfoDouble(ACCOUNT_MARGIN_LEVEL);
      MN_ACC_INFO.MARGIN_SO_CALL= AccountInfoDouble(ACCOUNT_MARGIN_SO_CALL);
      MN_ACC_INFO.MARGIN_SO_SO= AccountInfoDouble(ACCOUNT_MARGIN_SO_SO);
      MN_ACC_INFO.MARGIN_INITIAL= AccountInfoDouble(ACCOUNT_MARGIN_INITIAL);
      MN_ACC_INFO.MARGIN_MAINTENANCE= AccountInfoDouble(ACCOUNT_MARGIN_MAINTENANCE);
      MN_ACC_INFO.ASSETS= AccountInfoDouble(ACCOUNT_ASSETS);
      MN_ACC_INFO.LIABILITIES= AccountInfoDouble(ACCOUNT_LIABILITIES);
      MN_ACC_INFO.COMMISSION_BLOCKED= AccountInfoDouble(ACCOUNT_COMMISSION_BLOCKED);
      
   }
//+------------------------------------------------------------------+
//|终端信息                                                                  |
//+------------------------------------------------------------------+
struct Terminal_Info
   { 
     bool CONNECTED;             //连接的交易服务器
     bool DLLS_ALLOWED;          //设置里DLL打钩
     bool TRADE_ALLOWED;         //自动交易按钮开关
     bool TRADE_Platform;        //(平台是否能使用EA交易)
     int CPU_CORES;              //统的CPU 内核数量
     int DISK_SPACE;             //空闲磁盘空间，MB 
     int MEMORY_PHYSICAL;        //系统的物理内存，MB
     bool X64;                   //"64-位程序端"
     string  PATH;               //程序端文件夹启动
     string  DATA_PATH;          //程序端数据文件夹存储
     string  COMMONDATA_PATH;    //电脑中所有程序端的普通路径
//--- 终端信息度读取
   //~Terminal_Info(){Print("This is the end");};
   }MN_Terminal_info;
   
void  MN_Terminal_info(){
      MN_Terminal_info.CONNECTED=TerminalInfoInteger(TERMINAL_CONNECTED);
      MN_Terminal_info.DLLS_ALLOWED=TerminalInfoInteger(TERMINAL_DLLS_ALLOWED);
      MN_Terminal_info.TRADE_ALLOWED=TerminalInfoInteger(TERMINAL_TRADE_ALLOWED);
      MN_Terminal_info.TRADE_Platform=MarketInfo(Symbol(),MODE_TRADEALLOWED);
      MN_Terminal_info.CPU_CORES=TerminalInfoInteger(TERMINAL_CPU_CORES);
      MN_Terminal_info.MEMORY_PHYSICAL=TerminalInfoInteger(TERMINAL_MEMORY_PHYSICAL);
      MN_Terminal_info.DISK_SPACE=TerminalInfoInteger(TERMINAL_DISK_SPACE);
      MN_Terminal_info.X64=TerminalInfoInteger(TERMINAL_X64);
      MN_Terminal_info.PATH=TerminalInfoString(TERMINAL_PATH);
      MN_Terminal_info.DATA_PATH=TerminalInfoString(TERMINAL_DATA_PATH);
      MN_Terminal_info.COMMONDATA_PATH=TerminalInfoString(TERMINAL_COMMONDATA_PATH);
   }
   
//+------------------------------------------------------------------+
//|货币对信息                                                                  |
//+------------------------------------------------------------------+


struct Sym_info
   {
   bool SELECT;                     //在市场报价中选择交易品种
   bool VISIBLE;                    /*交易品种在市场报价中可见。
                                       一些交易品种（主要是计算入金货币预付款要求或利润所需的交叉率）被自动选择，
                                       但通常在市场报价中不可见。若要显示这些交易品种，就需要选择显式显示。*/
   long SESSION_DEALS;              //当前时期的交易数量 
   long SESSION_BUY_ORDERS;         //当时的买入订单数量
   long SESSION_SELL_ORDERS;        //当时的卖出订单数量
   long VOLUME;                     //最后订单成交量
   long VOLUMEHIGH;                 //当天最大订单
   long VOLUMELOW;                  //当天最小订单
   long  TIME;                      //最后报价时间
   long DIGITS;                     //小数点后数字
   bool SPREAD_FLOAT;               //浮点传播迹象，浮动点差
   long SPREAD;                     //相关传播值
   long TICKS_BOOKDEPTH;            //显示在市场深度要求中的最大数量，交易品种无队列要求，值是0
   long TRADE_CALC_MODE;            //合约价格计算方式
   long TRADE_MODE;                 //订单执行类型
   long TRADE_STOPS_LEVEL;          //止蚀盘当前收盘价格的最小空间
   long TRADE_FREEZE_LEVEL;         //凝结交易操作的距离
   long TRADE_EXEMODE;              //订单执行方式
   long SWAP_ROLLOVER3DAYS;         //日翻滚收费
   long EXPIRATION_MODE ;           //到期模式 允许命令标志
   long FILLING_MODE;               //填充模式 允许命令标志
   long ORDER_MODE;                 //允许的标识 订单类型
   //---
   double BID;                       //卖价
   double ASK;                       //卖价
   double LOW;                       //最低价
   double HIGH;                      //最高价   
   double TIME_;                     //最后输入的嘀嗒时间（最后已知的服务器时间）
   double SPREAD_;                   //点差
   double STOPLEVEL;                 /*限制止盈止损，一个零点值意味着对停止丢失/取利润的最小距离没有任何限制，
                                      或者交易服务器利用一些外部机制进行动态水平控制，这不能在客户终端中被翻译。
                                      在第二种情况下，GETLASTError（）可以返回错误130，因为MyDyStoPrVar实际上是“浮动”的。*/
   double LOTSIZE;                   //基本货币
   double TICKVALUE;                 //存款货币的票面价值
   double TICKSIZE;                  //最小点数
   double SWAPLONG;                  //买隔夜利息
   double SWAPSHORT;                 //卖隔夜利息
   bool   TRADEALLOWED;              //本货币允许交易
   double MINLOT;                    //最小交易手数
   double LOTSTEP;                   //卖价—最佳买入信息
   double MAXLOT;                    //卖价—最佳买入信息
   double SWAPTYPE;                  //利息计算法。0-点值；1 -在符号基础货币；2 -按利息；3 -在保证金货币
   double PROFITCALCMODE;            //利润的计算模式。0 - Forex; 1 - CFD; 2 - Futures
   double MARGINCALCMODE;            //保证金计算模式。0 -外汇；1 - CFD；2 -期货；3 -指数的CFD
   double MARGININIT;                //1手的初始保证金要求
   double MARGINMAINTENANCE ;        //维持1手的初始保证金要求
   double MARGINHEDGED ;             // 1手保证金的计算
   double MARGINREQUIRED;            //可用保证金
   double FREEZELEVEL;               //点冻结订单级别。如果执行价格位于冻结级别定义的范围内，则不能修改、取消或关闭订单。
   bool CLOSEBY_ALLOWED;           //允许使用OrdCuteleBee（）关闭指定符号上的相反顺序

   double POINT;                     //交易品种点值
   double TRADE_TICK_VALUE;          //SYMBOL_TRADE_TICK_VALUE_PROFIT的值
   double TRADE_TICK_SIZE;           //最小价格改变
   double TRADE_CONTRACT_SIZE;       //交易合约大小 
   double VOLUME_MIN;                //一笔订单中的最小成交量
   double VOLUME_MAX;                //一笔订单中的最大成交量  
   double VOLUME_STEP;               //交易执行的最小成交量更改步骤
   double SWAP_LONG;                 //买入库存费值
   double SWAP_SHORT;                //卖出库存费值 
   double MARGIN_INITIAL;            //原始保证金表示每一笔保证金开仓成交量的数量
   double MARGIN_MAINTENANCE;        //维持保证金，在交易品种中建立保证金数量，从一笔订单中获得保证金利润，当客户账户改变时，使用客户资产检测系统，如果维持保证金等于，使用原始保证金
   double MARGIN_HEDGED;             //锁仓持仓每手的合约大小或预付款值（一个交易品种的反向持仓）。锁仓持仓可以使用两种预付款计算方式。计算方式由交易商定义。
   //---
   string CURRENCY_BASE;             //交易品种基础货币
   string CURRENCY_PROFIT;           //利润货币
   string CURRENCY_MARGIN;           //保证金货币
   string BANK;                      //当前报价支线
   string DESCRIPTION;               //交易品种描述
   string ISIN;                      //用于自定义交易品种定价的公式
   string PATH;                      //交易品种树形通路
   //Sym_info()
   }MN_Sym_info;
   
   
//+------------------------------------------------------------------+
//|读取货币信息                                                                  |
//+------------------------------------------------------------------+
 void CB_Sym_info(string sym_0 )
  {
     MN_Sym_info.SELECT= SymbolInfoInteger(sym_0, SYMBOL_SELECT);
     MN_Sym_info.VISIBLE= SymbolInfoInteger(sym_0,SYMBOL_VISIBLE);
     MN_Sym_info.SESSION_DEALS= SymbolInfoInteger(sym_0, SYMBOL_SESSION_DEALS);
     MN_Sym_info.SESSION_BUY_ORDERS= SymbolInfoInteger(sym_0,SYMBOL_SESSION_BUY_ORDERS);
     MN_Sym_info.SESSION_SELL_ORDERS= SymbolInfoInteger(sym_0,SYMBOL_SESSION_SELL_ORDERS);     
     MN_Sym_info.VOLUME= SymbolInfoInteger(sym_0, SYMBOL_VOLUME);
     MN_Sym_info.VOLUMEHIGH= SymbolInfoInteger(sym_0, SYMBOL_VOLUMEHIGH);
     MN_Sym_info.VOLUMELOW= SymbolInfoInteger(sym_0,SYMBOL_VOLUMELOW);
     MN_Sym_info.TIME= SymbolInfoInteger(sym_0, SYMBOL_TIME);
     MN_Sym_info.DIGITS= SymbolInfoInteger(sym_0,SYMBOL_DIGITS);
     MN_Sym_info.SPREAD_FLOAT= SymbolInfoInteger(sym_0, SYMBOL_SPREAD_FLOAT);
     MN_Sym_info.SPREAD= SymbolInfoInteger(sym_0, SYMBOL_SPREAD);
     MN_Sym_info.VISIBLE= SymbolInfoInteger(sym_0,SYMBOL_SPREAD_FLOAT);
     MN_Sym_info.TICKS_BOOKDEPTH= SymbolInfoInteger(sym_0, SYMBOL_TICKS_BOOKDEPTH);
     MN_Sym_info.TRADE_CALC_MODE= SymbolInfoInteger(sym_0,SYMBOL_TRADE_CALC_MODE);
     MN_Sym_info.TRADE_MODE= SymbolInfoInteger(sym_0, SYMBOL_TRADE_MODE);
     MN_Sym_info.TRADE_STOPS_LEVEL= SymbolInfoInteger(sym_0, SYMBOL_TRADE_STOPS_LEVEL);
     MN_Sym_info.TRADE_FREEZE_LEVEL= SymbolInfoInteger(sym_0,SYMBOL_TRADE_FREEZE_LEVEL);
     MN_Sym_info.TRADE_EXEMODE= SymbolInfoInteger(sym_0, SYMBOL_TRADE_EXEMODE);
     MN_Sym_info.SWAP_ROLLOVER3DAYS= SymbolInfoInteger(sym_0, SYMBOL_SWAP_ROLLOVER3DAYS);
     MN_Sym_info.EXPIRATION_MODE= SymbolInfoInteger(sym_0, SYMBOL_EXPIRATION_MODE );
     MN_Sym_info.FILLING_MODE= SymbolInfoInteger(sym_0,SYMBOL_FILLING_MODE);
     MN_Sym_info.ORDER_MODE= SymbolInfoInteger(sym_0, SYMBOL_ORDER_MODE);
     //---
     MN_Sym_info.BID= SymbolInfoDouble(sym_0,SYMBOL_BID);
     MN_Sym_info.ASK= SymbolInfoDouble(sym_0,SYMBOL_ASK);
     MN_Sym_info.LOW= MarketInfo(sym_0,MODE_LOW);
     MN_Sym_info.HIGH= MarketInfo(sym_0,MODE_HIGH);
     MN_Sym_info.SPREAD_= MarketInfo(sym_0,MODE_SPREAD);
     MN_Sym_info.STOPLEVEL= MarketInfo(sym_0,MODE_STOPLEVEL);
     MN_Sym_info.LOTSIZE= MarketInfo(sym_0,MODE_LOTSIZE);
     MN_Sym_info.TICKVALUE= MarketInfo(sym_0,MODE_TICKVALUE);
     MN_Sym_info.TICKSIZE= MarketInfo(sym_0,MODE_TICKSIZE);
     MN_Sym_info.SWAPLONG= MarketInfo(sym_0,MODE_SWAPLONG);
     MN_Sym_info.SWAPSHORT= MarketInfo(sym_0,MODE_SWAPSHORT);
     MN_Sym_info.TRADEALLOWED= MarketInfo(sym_0,MODE_TRADEALLOWED);
     MN_Sym_info.MINLOT= MarketInfo(sym_0,MODE_MINLOT);
     MN_Sym_info.LOTSTEP= MarketInfo(sym_0,MODE_LOTSTEP);
     MN_Sym_info.MAXLOT= MarketInfo(sym_0,MODE_MAXLOT);
     MN_Sym_info.SWAPTYPE= MarketInfo(sym_0,MODE_SWAPTYPE);
     MN_Sym_info.MARGINCALCMODE= MarketInfo(sym_0,MODE_MARGINCALCMODE);
     MN_Sym_info.MARGININIT= MarketInfo(sym_0,MODE_MARGININIT);
     MN_Sym_info.MARGINMAINTENANCE= MarketInfo(sym_0,MODE_MARGINMAINTENANCE);
     MN_Sym_info.MARGINHEDGED= MarketInfo(sym_0,MODE_MARGINHEDGED);
     MN_Sym_info.MARGINREQUIRED= MarketInfo(sym_0,MODE_MARGINREQUIRED);
     MN_Sym_info.FREEZELEVEL= MarketInfo(sym_0,MODE_FREEZELEVEL);
     MN_Sym_info.CLOSEBY_ALLOWED= MarketInfo(sym_0,MODE_CLOSEBY_ALLOWED);
     //---     
     MN_Sym_info.POINT= SymbolInfoDouble(sym_0,SYMBOL_POINT);
     MN_Sym_info.TRADE_TICK_VALUE=SymbolInfoDouble(sym_0,SYMBOL_TRADE_TICK_VALUE);
     MN_Sym_info.TRADE_TICK_SIZE= SymbolInfoDouble(sym_0,SYMBOL_TRADE_TICK_SIZE);
     MN_Sym_info.TRADE_CONTRACT_SIZE= SymbolInfoDouble(sym_0,SYMBOL_TRADE_CONTRACT_SIZE);
     MN_Sym_info.VOLUME_MIN= SymbolInfoDouble(sym_0,SYMBOL_VOLUME_MIN);
     MN_Sym_info.VOLUME_MAX= SymbolInfoDouble(sym_0, SYMBOL_VOLUME_MAX);
     MN_Sym_info.VOLUME_STEP= SymbolInfoDouble(sym_0,SYMBOL_VOLUME_STEP);
     MN_Sym_info.MARGIN_INITIAL= SymbolInfoDouble(sym_0,SYMBOL_MARGIN_INITIAL);
     MN_Sym_info.MARGIN_MAINTENANCE= SymbolInfoDouble(sym_0,SYMBOL_MARGIN_MAINTENANCE);
     //---
     MN_Sym_info.CURRENCY_BASE= SymbolInfoString(sym_0,SYMBOL_CURRENCY_BASE);      
     MN_Sym_info.CURRENCY_PROFIT=SymbolInfoString(sym_0,SYMBOL_CURRENCY_PROFIT);
     MN_Sym_info.CURRENCY_MARGIN= SymbolInfoString(sym_0,SYMBOL_CURRENCY_MARGIN);
     MN_Sym_info.BANK= SymbolInfoString(sym_0,SYMBOL_BANK);
     MN_Sym_info.DESCRIPTION= SymbolInfoString(sym_0,SYMBOL_DESCRIPTION);
     MN_Sym_info.ISIN= SymbolInfoString(sym_0,SYMBOL_ISIN); 
     MN_Sym_info.PATH= SymbolInfoString(sym_0,SYMBOL_PATH);
  }
   
//系统变量
int MN_TimeCount=0;//当前时间

string Mn_obj_0="_";   
string Mn_obj_reght="R_";   
string Mn_obj_reght_=Mn_obj_reght+"S_";   
string Mn_obj_reght_0=Mn_obj_reght_+"0_";   
string Mn_obj_reght_1=Mn_obj_reght_+"1_";   
string Mn_obj_reght_2=Mn_obj_reght_+"2_";   
string Mn_obj_reght_3=Mn_obj_reght_+"3_";   
string Mn_obj_reght_4=Mn_obj_reght_+"4_";   
string Mn_obj_reght_5=Mn_obj_reght_+"5_";   
string Mn_obj_reght_6=Mn_obj_reght_+"6_";   
string Mn_obj_reght_7=Mn_obj_reght_+"7_";   
string Mn_obj_reght_8=Mn_obj_reght_+"8_";   
string Mn_obj_reght_9=Mn_obj_reght_+"9_";   
string Mn_obj_reght_10=Mn_obj_reght_+"10_";   
string Mn_obj_reght_page=Mn_obj_reght_+"11_";   
string Mn_obj_reght_guangao=Mn_obj_reght_+"12_";   

#define  Mn_right_win_count 9
#define  Mn_pnl_reght 0
//#define  Mn_pnl_reght_guangao 
int Mn_panal_main=false;
bool Mn_panal_guangao=false;
int Mn_panal_run[Mn_right_win_count]; //当前运行窗口    
string  Mn_panal_name[Mn_right_win_count]={"当前/历史订单",
                                             "盈亏统计",
                                             "资金曲线",
                                             "交易品种",
                                             "回报表现",
                                             "数据中心",
                                             "策略系统",
                                             "黑马系统",
                                             //"筯斗云跟单",
                                             "会员中心"};   

#define  _PI    3.14
#define  _2PI   6.28

//下单区变量
string tradesymbol=Symbol();//交易货币对  
double tradelots=0.01;
double tradesl=0;               
double tradetp=0;  

bool can_object_create_r = true;
bool ris_riskswitch = false;

//主界面变量
//绘制仪表盘---------------------------------------------------------------------------------------------|
bool can_object_create=true;


//风控圈图
extern double si=1.0;
extern int ris_x=20;
extern int ris_y=200;

/*
string clo_FontName="Arial";
int    clo_fontsize_5=5;
int    clo_fontsize_6=6;
int    clo_fontsize_8=8;

   

//风控圈图
extern double si=1.0;
extern int ris_x=20;
extern int ris_y=200;




*/

double ris_risklable[5]={2,8,15,20,30};

//int MN_TimeCount=0;//当前时间
int MN_PosTradeCount=0;//当前订单数量
int MN_HisTradeCount=0;//历史订单数量
int MN_his_start_ticket=0;//历史0号订单，订单号。
          
//+------------------------------------------------------------------+
//|历史订单列表 
//|MN_histrade                                                                 |
//+------------------------------------------------------------------+
struct MN_his_trade
  {
   int         num;        //订单序号
   int         ticket;     //订单号
   datetime    opentime;   //开仓时间
   int         type;       //交易类型
   double      lot;        //手数
   string      symbol;     //货币名称
   double      openprice;  //开仓价格
   double      stoploss;   //止损
   double      takeprofit; //止赢
   datetime    closetime;  //平仓时间
   double      closeprice; //平仓价格
   double      commission; //手续费
   double      swap;       //库存费
   int         point;     //点数
   double      profit;     //获利
   string      comment;    //注释
   long        magic;    //注释
   ~MN_his_trade(){;}
  }MN_histrade[],MN_postrade[];
//+------------------------------------------------------------------+
//|日收益统计                                                                  |
//|MN_HisStatistics_day[0]为空值                                                                  |
//+------------------------------------------------------------------+
struct MN_His_Statistics_Day
  {
   int       serial;     //序号
   int       dateSort;   //日期排序编号
   datetime    year;       //日期
   datetime    quarter;       //日期
   datetime    mon;       //日期
   datetime    week;       //日期
   datetime    day;       //日期
   double    lot;        //手数
   double    lotb;        //手数
   double    lots;        //手数
   int       count;      //次数
   int       countb;      //次数
   int       counts;      //次数
   double    access;     //出入金
   double    balance;    //余额
   double    commission; //手续费
   double    swap;       //库存费
   double    profit;     //获利
   double    rate;       //百分比
   ~MN_His_Statistics_Day(){;}
  }MN_HisStatistics_day[],MN_HisStatistics_week[],MN_HisStatistics_mon[],MN_HisStatistics_quarter[],MN_HisStatistics_year[];


//+------------------------------------------------------------------+
//|当前订单统计                                                                  |
//+------------------------------------------------------------------+
struct MN_heima_postrade
  {
   string      symbol;     //货币名称
   double      Yesterday_close;//昨天收盘价
   double      today_close;//今天收盘价
   double         now_ask; //现卖价
   double         now_bid; //现买价
   int         trade_count; //订单数量
   double      lot;        //手数
   double      lot_b;        //多手数
   double      lot_s;        //空手数
   double      profit;     //获利
   double      start_lot;    //
   int      amount_sl;      //
   int      Add_cou;      //
   bool     sym_permit;      //
   int     magic;      //
   ~MN_heima_postrade(){}
  }heima_postrade[OpenOrders];              

//+-------------------------SQL------------------------------------
string   KAccID,KAccnum,KAccpass,Kcoin,Kintegral,KAccpassword;
int shift_key=0,caps_key=0;

//------------------StratagemSystem-------------------------------
string StratagSys[100][100];//货币名称或者策略名称

string object_name[];

int Kirin_tacket[];

int Jindouyun_acc[5];
struct Page
  {
int page;
int page_max;
Page(){
page=1;
}
  }page_;
