#ifdef _SUPPORTS_DETOURS
init_detours()
{
    compiler::detour();
}
#endif

detour zm_silver_main_quest<scripts\zm\zm_silver_main_quest.gsc>::function_5c9f6aa5(b_skipped){
    self [[@zm_silver_main_quest<scripts\zm\zm_silver_main_quest.gsc>::function_5c9f6aa5]](true);
}