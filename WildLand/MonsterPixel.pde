class MonsterPixel {
  int monsterPixelRowNumber;
  int[] monsterPixelRowPixels;
  color monsterPixelColor;
}

MonsterPixel createMP(int mPRN, int[] mPRP, color mPC) {
  MonsterPixel mp = new MonsterPixel();
  mp.monsterPixelRowNumber = mPRN;
  mp.monsterPixelRowPixels = mPRP;
  mp.monsterPixelColor = mPC;
  return mp;
}

color monsterADarker = color(120, 30, 60);
color monsterABody = color(150, 0, 50);
color monsterAShadow = color(90, 0, 30);
color monsterAEye = color(255, 0, 0);
color monsterAHorn = color(180, 180, 180);
//all int[]'s value need -1, they are x and y and from painting software
MonsterPixel[] mp = {
  createMP(3, new int[]{7, 13}, monsterADarker),
  createMP(4, new int[]{2, 7}, monsterADarker),
  createMP(5, new int[]{2, 5}, monsterADarker),
  createMP(6, new int[]{1, 4}, monsterADarker),
  createMP(7, new int[]{1, 4}, monsterADarker),
  createMP(8, new int[]{1, 5}, monsterADarker),
  createMP(9, new int[]{1, 6}, monsterADarker),
  createMP(10, new int[]{1, 2}, monsterADarker),
  createMP(11, new int[]{2, 4}, monsterADarker),
  createMP(12, new int[]{4, 30}, monsterADarker),
  createMP(13, new int[]{6, 29}, monsterADarker),
  createMP(14, new int[]{7, 23}, monsterADarker),
  createMP(15, new int[]{6, 11}, monsterADarker),
  createMP(15, new int[]{16, 22}, monsterADarker),
  createMP(16, new int[]{5, 11}, monsterADarker),
  createMP(16, new int[]{15, 20}, monsterADarker),
  createMP(17, new int[]{4, 10}, monsterADarker),
  createMP(17, new int[]{15, 19}, monsterADarker),
  createMP(18, new int[]{3, 7}, monsterADarker),
  createMP(18, new int[]{15, 20}, monsterADarker),
  createMP(19, new int[]{2, 6}, monsterADarker),
  createMP(19, new int[]{15, 22}, monsterADarker),
  createMP(20, new int[]{2, 7}, monsterADarker),
  createMP(20, new int[]{16, 23}, monsterADarker),
  createMP(2, new int[]{5, 11}, monsterABody),
  createMP(3, new int[]{3, 6}, monsterABody),
  createMP(4, new int[]{3, 4}, monsterABody),
  createMP(5, new int[]{3, 3}, monsterABody),
  createMP(6, new int[]{3, 3}, monsterABody),
  createMP(6, new int[]{14, 22}, monsterABody),
  createMP(7, new int[]{2, 3}, monsterABody),
  createMP(7, new int[]{10, 25}, monsterABody),
  createMP(8, new int[]{2, 3}, monsterABody),
  createMP(8, new int[]{8, 26}, monsterABody),
  createMP(9, new int[]{2, 4}, monsterABody),
  createMP(9, new int[]{7, 27}, monsterABody),
  createMP(10, new int[]{3, 28}, monsterABody),
  createMP(11, new int[]{5, 30}, monsterABody),
  createMP(12, new int[]{7, 28}, monsterABody),
  createMP(13, new int[]{8, 22}, monsterABody),
  createMP(14, new int[]{8, 10}, monsterABody),
  createMP(14, new int[]{17, 21}, monsterABody),
  createMP(15, new int[]{8, 10}, monsterABody),
  createMP(15, new int[]{17, 19}, monsterABody),
  createMP(16, new int[]{7, 9}, monsterABody),
  createMP(16, new int[]{17, 18}, monsterABody),
  createMP(17, new int[]{6, 6}, monsterABody),
  createMP(17, new int[]{16, 18}, monsterABody),
  createMP(18, new int[]{5, 5}, monsterABody),
  createMP(18, new int[]{16, 18}, monsterABody),
  createMP(19, new int[]{4, 5}, monsterABody),
  createMP(19, new int[]{17, 19}, monsterABody),
  createMP(15, new int[]{23, 23}, monsterAShadow),
  createMP(16, new int[]{21, 24}, monsterAShadow),
  createMP(17, new int[]{21, 26}, monsterAShadow),
  createMP(18, new int[]{8, 10}, monsterAShadow),
  createMP(18, new int[]{22, 27}, monsterAShadow),
  createMP(19, new int[]{8, 11}, monsterAShadow),
  createMP(10, new int[]{25, 26}, monsterAEye),
  createMP(6, new int[]{21, 21}, monsterAHorn),
  createMP(6, new int[]{24, 24}, monsterAHorn),
  createMP(7, new int[]{21, 22}, monsterAHorn),
  createMP(8, new int[]{22, 24}, monsterAHorn),
  createMP(9, new int[]{24, 26}, monsterAHorn),
  createMP(12, new int[]{29, 29}, monsterAHorn),
  createMP(13, new int[]{27, 27}, monsterAHorn),
};
