game.codepage="UTF-8";
game.act = 'نمی‌تونم';
game.inv = 'عحب...غلطه...';
game.use = 'نمی‌شه...';
game.dsc = [[Commands:^
    look (or just Enter), act <on what> (or just on what), use <what> [on what], go <where>,^
    back, inv, way, obj, quit, save <fname>, load <fname>. Tab to autocomplete.^^
Oleg G., Vladimir P., Ilia R., et al. in the science-fiction and dramatic text adventure by Pyotr K.^^
THE RETURNING OF THE QUANTUM CAT^^
Former hacker. He left to live in the forest. But he's back. Back for his cat.^^
“I JUST CAME TO GET BACK MY CAT...” ^^]];

--require "dbg";

me().nam = 'Oleg';
main = room {
	nam = 'نجات گربه‌ی کوانتومی',
	pic = 'gfx/thecat.png',
	dsc = [[
	بیرون خونه‌ی من برف بازم همه جا رو سفید کرده. صدای ترک‌های چوب توی شومینه بازم مثل اون روزه... زمستون سوم هم رسید.
	دو تا زمستون گذشته اما چیزهایی که می‌خوام تعریف کنم طوری جلوی چشمام رژه می‌رن انگاری که همین دیروز اتفاق افتادن...^^
من ده سال به عنوان جنگلبان کار می‌کردم. تموم این ده سال توی کلبه‌ام تو جنگل زندگی کردم و تله‌های شکارچی‌ها رو جمع کردم. هر یکی دو هفته یه سر می‌رفتم شهری همون نزدیکی... یه دفعه بعد از مراسم روز یکشنبه تو کلیسای محل رفتم به فروشگاه برای خرید چیز میزایی که لازم داشتم. چیزهایی مثل فشنگ شاتگان و ذرت و گندم و نون و دارو و این جور چیزا...^^

قبلا یه متخصص آی‌تی مشتی بودم... اما این قضیه دیگه مهم نیست... ده سالیه که مونیتور یه کامپیوتر رو هم ندیدم و اصلا هم پشیمون نیستم...^^

حالا می‌فهمم که همه‌ی اون ماجراها ریشه تو اوائل دهه سی داره... اما بهتره همه چیز رو یواش یواش تعریف کنم...^^

یه روز سرد ماه فوریه بود و داشتم آماده می‌شدم که مثل همیشه برم شهر...]],
obj = { vobj(1,'Next','{بعدی}.') },
act = function()
	return walk('home');
end,
exit = function()
	set_music("mus/ofd.xm");
end,
};
set_music("mus/new.s3m");
dofile("ep1-fa.lua");
dofile("ep2-fa.lua");
dofile("ep3-fa.lua");

me().where = 'eroom';
--inv():add('mywear');
--inv():add('gun');
--inv():add('trap');

