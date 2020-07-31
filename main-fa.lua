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
	دو تا زمستون گذشته اما چیزهایی که می‌خوام تعریف کنم طوری جلوی چشمام هستن انگاری که همین دیروز اتفاق افتادن...^^

]],
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

