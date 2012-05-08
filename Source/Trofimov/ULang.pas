unit ULang;

interface

uses Classes;

procedure LoadLangData;

procedure SetLang(iLang : Integer);

procedure SetLangData;

type
  TLngRecord = record
    bIsLoad : Boolean;
    sName, sFileName : AnsiString;
    slLoad : TStringList;
  end;

const
  LngNum = 2;
  iImageNum = 60;
//  StrNum = 171;

var
  LngData : array [0..LngNum - 1] of TLngRecord;
  slLang : TStringList;

const
  saImageNameRu : array [0..iImageNum - 1] of AnsiString =
    (
    'Объект полутоновое', //0
    'Объект интерферограмма 1', //1
    'Объект интерферограмма 2', //2
    'Объект интерферограмма 3', //3
    'База полутоновое', //4
    'База интерферограмма 1', //5
    'База интерферограмма 2', //6
    'База интерферограмма 3', //7
    'Квадратичные коэффициент перевода в мм', //8
    'Линейные коэффициент перевода в мм', //9
    'Постоянный коэффициент перевода в мм', //10
    'Область выделения', //11
    'Объект полутоновое предобработка', //12
    'Объект интерферограмма 1 предобработка', //13
    'Объект интерферограмма 2 предобработка', //14
    'Объект интерферограмма 3 предобработка', //15
    'База полутоновое предобработка', //16
    'База интерферограмма 1 предобработка', //17
    'База интерферограмма 2 предобработка', //18
    'База интерферограмма 3 предобработка', //19
    'Объект полутоновое спектр', //20
    'Объект интерферограмма 1 спектр', //21
    'Объект интерферограмма 2 спектр', //22
    'Объект интерферограмма 3 спектр', //23
    'База полутоновое спектр', //24
    'База интерферограмма 1 спектр', //25
    'База интерферограмма 2 спектр', //26
    'База интерферограмма 3 спектр', //27
    'Объект интерферограмма 1 спектр фильтрованный', //28
    'Объект интерферограмма 2 спектр фильтрованный', //29
    'Объект интерферограмма 3 спектр фильтрованный', //30
    'База интерферограмма 1 спектр фильтрованный', //31
    'База интерферограмма 2 спектр фильтрованный', //32
    'База интерферограмма 3 спектр фильтрованный', //33
    'Объект интерферограмма 1 фаза', //34
    'Объект интерферограмма 2 фаза', //35
    'Объект интерферограмма 3 фаза', //36
    'База интерферограмма 1 фаза', //37
    'База интерферограмма 2 фаза', //38
    'База интерферограмма 3 фаза', //39
    'Ракурс 1 фаза', //40
    'Ракурс 2 фаза', //41
    'Ракурс 3 Фаза', //42
    'Фурье синтез - фаза', //43
    'Сшитая фаза', //44
    'Постобработка фазы', //45
    'Трансформированный профиль', //46
    'Результат - Восстановленный профиль', //47
    'Трансформированная область выделения', //48
    'Профиль в мм', //49
    'Объект интерферограмма 1 амплитуда', //50
    'База интерферограмма 1 амплитуда', //51
    'Ракурс 1 амплитуда', //52
    'Объект интерферограмма 2 амплитуда', //53
    'База интерферограмма 2 амплитуда', //54
    'Ракурс 2 амплитуда', //55
    'Объект интерферограмма 3 амплитуда', //56
    'База интерферограмма 3 амплитуда', //57
    'Ракурс 3 амплитуда', //58
    'Фурье синтез - амплитуда' //59
    );
  saImageNameEn : array [0..iImageNum - 1] of AnsiString =
    (
    'Object grayscale', //0
    'Object interferogram 1', //1
    'Object interferogram 2', //2
    'Object interferogram 3', //3
    'Base grayscale', //4
    'Base interferogram 1', //5
    'Base interferogram 2', //6
    'Base interferogram 3', //7
    'Quadratic koeff transform to mm', //8
    'Linear koeff transform to mm', //9
    'Constant koeff transform to mm', //10
    'Object mask', //11
    'Object grayscale preprocess', //12
    'Object interferogram 1 preprocess', //13
    'Object interferogram 2 preprocess', //14
    'Object interferogram 3 preprocess', //15
    'Base grayscale preprocess', //16
    'Base interferogram 1 preprocess', //17
    'Base interferogram 2 preprocess', //18
    'Base interferogram 3 preprocess', //19
    'Object grayscale spectrum', //20
    'Object interferogram 1 spectrum', //21
    'Object interferogram 2 spectrum', //22
    'Object interferogram 3 spectrum', //23
    'Base grayscale spectrum', //24
    'Base interferogram 1 spectrum', //25
    'Base interferogram 2 spectrum', //26
    'Base interferogram 3 spectrum', //27
    'Object interferogram 1 filtered spectrum', //28
    'Object interferogram 2 filtered spectrum', //29
    'Object interferogram 3 filtered spectrum', //30
    'Base interferogram 1 filtered spectrum', //31
    'Base interferogram 2 filtered spectrum', //32
    'Base interferogram 3 filtered spectrum', //33
    'Object interferogram 1 phase', //34
    'Object interferogram 2 phase', //35
    'Object interferogram 3 phase', //36
    'Base interferogram 1 phase', //37
    'Base interferogram 2 phase', //38
    'Base interferogram 3 phase', //39
    'View 1 phase', //40
    'View 2 phase', //41
    'View 3 phase', //42
    'Fourier synthesis phase', //43
    'Unwrapped phase', //44
    'Postprocessed phase', //45
    'Transformed surface', //46
    'Result - reconstructed surface', //47
    'Transformed object mask', //48
    'Surface', //49
    'Object interferogram 1 amplitude', //50
    'Base interferogram 1 amplitude', //51
    'View 1 amplitude', //52
    'Object interferogram 2 amplitude', //53
    'Base interferogram 2 amplitude', //54
    'View 2 amplitude', //55
    'Object interferogram 3 amplitude', //56
    'Base interferogram 3 amplitude', //57
    'View 3 amplitude', //58
    'Fourier synthesis amplitude' //59
    );

implementation

uses SysUtils, Unit1, Unit7, UTreeParam, ComCtrls, Unit8, Unit9, Dialogs, Menus,
  UFormLine;

procedure SetEnLangData;
begin
  LngData[0].slLoad := TStringList.Create;
  LngData[0].slLoad.Add('MouthScanner v.2.2');    //0
  LngData[0].slLoad.Add('File');                  //1
  LngData[0].slLoad.Add('Open real image...');    //2
  LngData[0].slLoad.Add('Open interferogram 1...');
  LngData[0].slLoad.Add('Open interferogram 2...');
  LngData[0].slLoad.Add('Open interferogram 3...');
  LngData[0].slLoad.Add('Open base real image...');
  LngData[0].slLoad.Add('Open base interferogram 1...');
  LngData[0].slLoad.Add('Open base interferogram 2...');
  LngData[0].slLoad.Add('Open base interferogram 3...');
  LngData[0].slLoad.Add('Open quadratic koeff...');  //10
  LngData[0].slLoad.Add('Open linear koeff...');
  LngData[0].slLoad.Add('Open constant koeff...');
  LngData[0].slLoad.Add('Open images...');
  LngData[0].slLoad.Add('Open base images...');
  LngData[0].slLoad.Add('Open koeff images...');
  LngData[0].slLoad.Add('Save...');
  LngData[0].slLoad.Add('Save view...');
  LngData[0].slLoad.Add('Exit');
  LngData[0].slLoad.Add('Reconstruction');
  LngData[0].slLoad.Add('Capture images');              //20
  LngData[0].slLoad.Add('Load 1st shot');
  LngData[0].slLoad.Add('Mark object region');
  LngData[0].slLoad.Add('Reconstruction');
  LngData[0].slLoad.Add('3DView');
  LngData[0].slLoad.Add('Options...');
  LngData[0].slLoad.Add('Window');
  LngData[0].slLoad.Add('Histogram');
  LngData[0].slLoad.Add('Graph X');
  LngData[0].slLoad.Add('Graph Y');
  LngData[0].slLoad.Add('View');                           //30
  LngData[0].slLoad.Add('object');
  LngData[0].slLoad.Add('base');
  LngData[0].slLoad.Add('real image');                     //33
  LngData[0].slLoad.Add('interferogram 1');
  LngData[0].slLoad.Add('interferogram 2');
  LngData[0].slLoad.Add('interferogram 3');
  LngData[0].slLoad.Add('base real image');
  LngData[0].slLoad.Add('base interferogram 1');
  LngData[0].slLoad.Add('base interferogram 2');
  LngData[0].slLoad.Add('base interferogram 3');            //40
  LngData[0].slLoad.Add('qudratic koeff');
  LngData[0].slLoad.Add('linear koeff');
  LngData[0].slLoad.Add('constant koeff');
  LngData[0].slLoad.Add('mask');
  LngData[0].slLoad.Add('preprocess - real image');
  LngData[0].slLoad.Add('preprocess - interferogram 1');
  LngData[0].slLoad.Add('preprocess - interferogram 2');
  LngData[0].slLoad.Add('preprocess - interferogram 3');
  LngData[0].slLoad.Add('preprocess - base real image');
  LngData[0].slLoad.Add('preprocess - base interferogram 1');  //50
  LngData[0].slLoad.Add('preprocess - base interferogram 2');
  LngData[0].slLoad.Add('preprocess - base interferogram 3');
  LngData[0].slLoad.Add('spectrum - real image');
  LngData[0].slLoad.Add('spectrum - interferogram 1');
  LngData[0].slLoad.Add('spectrum - interferogram 2');
  LngData[0].slLoad.Add('spectrum - interferogram 3');
  LngData[0].slLoad.Add('spectrum - base real image');
  LngData[0].slLoad.Add('spectrum - base interferogram 1');
  LngData[0].slLoad.Add('spectrum - base interferogram 2');
  LngData[0].slLoad.Add('spectrum - base interferogram 3');
  LngData[0].slLoad.Add('filtered spectrum - interferogram 1'); //60
  LngData[0].slLoad.Add('filtered spectrum - interferogram 2');
  LngData[0].slLoad.Add('filtered spectrum - interferogram 3');
  LngData[0].slLoad.Add('filtered spectrum - base interferogram 1');
  LngData[0].slLoad.Add('filtered spectrum - base interferogram 2');
  LngData[0].slLoad.Add('filtered spectrum - base interferogram 3');
  LngData[0].slLoad.Add('phase - interferogram 1');
  LngData[0].slLoad.Add('phase - interferogram 2');
  LngData[0].slLoad.Add('phase - interferogram 3');
  LngData[0].slLoad.Add('phase - base interferogram 1');
  LngData[0].slLoad.Add('phase - base interferogram 2');           //70
  LngData[0].slLoad.Add('phase - base interferogram 3');
  LngData[0].slLoad.Add('phase interferogram 1 mul phase base interferogram 1');
  LngData[0].slLoad.Add('phase interferogram 2 mul phase base interferogram 2');
  LngData[0].slLoad.Add('phase interferogram 3 mul phase base interferogram 3');
  LngData[0].slLoad.Add('wrapped phase');
  LngData[0].slLoad.Add('unwrapped phase');
  LngData[0].slLoad.Add('postprocessed phase');
  LngData[0].slLoad.Add('transformed height');
  LngData[0].slLoad.Add('reconstructed surface');
  LngData[0].slLoad.Add('reduced mask');                              //80
  LngData[0].slLoad.Add('height in mm');
  LngData[0].slLoad.Add('About');
  LngData[0].slLoad.Add('Ready');
  LngData[0].slLoad.Add('Calculation status');
  LngData[0].slLoad.Add('File already exist. Overwrite?');
  LngData[0].slLoad.Add('Attention');
  LngData[0].slLoad.Add('Supported formats');
  LngData[0].slLoad.Add('Please, mark object region');
  LngData[0].slLoad.Add('Min');
  LngData[0].slLoad.Add('Max');                                          //90
  LngData[0].slLoad.Add('Size X');
  LngData[0].slLoad.Add('Size Y');
  LngData[0].slLoad.Add('Please, mark unwrap begin point');
  LngData[0].slLoad.Add('Capture');
  LngData[0].slLoad.Add('Preprocessing');
  LngData[0].slLoad.Add('Fourier reconstruct');
  LngData[0].slLoad.Add('Unwrapping');
  LngData[0].slLoad.Add('Postprocessing');
  LngData[0].slLoad.Add('Files');
  LngData[0].slLoad.Add('Visualisation');                                  //100
  LngData[0].slLoad.Add('Auto contrast');
  LngData[0].slLoad.Add('Show histogram');
  LngData[0].slLoad.Add('Image filename');
  LngData[0].slLoad.Add('Number of frames');
  LngData[0].slLoad.Add('Start delay, frames');
  LngData[0].slLoad.Add('Image directory');
  LngData[0].slLoad.Add('Manual mark');
  LngData[0].slLoad.Add('Automatic mark');
  LngData[0].slLoad.Add('Object region');
  LngData[0].slLoad.Add('Min delete');       //110
  LngData[0].slLoad.Add('Gamma correction');
  LngData[0].slLoad.Add('Homomorph filter');
  LngData[0].slLoad.Add('Spectrum sub');
  LngData[0].slLoad.Add('Nothing');
  LngData[0].slLoad.Add('Quality increase');
  LngData[0].slLoad.Add('Base');
  LngData[0].slLoad.Add('Energy norm');
  LngData[0].slLoad.Add('1 view');
  LngData[0].slLoad.Add('2 view');
  LngData[0].slLoad.Add('3 view');               //120
  LngData[0].slLoad.Add('View number');
  LngData[0].slLoad.Add('View 1');
  LngData[0].slLoad.Add('View 2');
  LngData[0].slLoad.Add('View 3');
  LngData[0].slLoad.Add('Mul base');
  LngData[0].slLoad.Add('Move maximum');
  LngData[0].slLoad.Add('Base plane sub');
  LngData[0].slLoad.Add('Unwrap');
  LngData[0].slLoad.Add('Manual mark');
  LngData[0].slLoad.Add('Automatic mark');           //130
  LngData[0].slLoad.Add('Unwrap begin point');
  LngData[0].slLoad.Add('Median filter');
  LngData[0].slLoad.Add('Window size');
  LngData[0].slLoad.Add('Linear var win filter');
  LngData[0].slLoad.Add('Convert to mm');
  LngData[0].slLoad.Add('Optic transform');
  LngData[0].slLoad.Add('Cut by mask');
  LngData[0].slLoad.Add('pixels');
  LngData[0].slLoad.Add('Load');
  LngData[0].slLoad.Add('Save');                         //140
  LngData[0].slLoad.Add('Save with mask');
  LngData[0].slLoad.Add('Data directory');
  LngData[0].slLoad.Add('Black-White');
  LngData[0].slLoad.Add('Spectrum');
  LngData[0].slLoad.Add('Thermovizor');
  LngData[0].slLoad.Add('Palette');
  LngData[0].slLoad.Add('Number palette colors');
  LngData[0].slLoad.Add('4 colors');
  LngData[0].slLoad.Add('8 colors');
  LngData[0].slLoad.Add('16 colors');                       //150
  LngData[0].slLoad.Add('32 colors');
  LngData[0].slLoad.Add('64 colors');
  LngData[0].slLoad.Add('128 colors');
  LngData[0].slLoad.Add('256 colors');
  LngData[0].slLoad.Add('Show first derivative');
  LngData[0].slLoad.Add('Show second derivative');
  LngData[0].slLoad.Add('Show upper threshold');
  LngData[0].slLoad.Add('Value');
  LngData[0].slLoad.Add('Show lower threshold');
  LngData[0].slLoad.Add('Show intermediative results');         //160
  LngData[0].slLoad.Add('Smtcam directory');
  LngData[0].slLoad.Add('Language');
  LngData[0].slLoad.Add('Rotate angle');
  LngData[0].slLoad.Add('Mirror');
  LngData[0].slLoad.Add('Axis');
  LngData[0].slLoad.Add('Koeff''s for phase to map');
  LngData[0].slLoad.Add('English');
  LngData[0].slLoad.Add('Russian');
  LngData[0].slLoad.Add('Save graph X...');
  LngData[0].slLoad.Add('Save graph Y...');               //170
  LngData[0].slLoad.Add('Save histogram...');
  LngData[0].slLoad.Add('Shift phase');
  LngData[0].slLoad.Add('Open reconstructed surface...');
  LngData[0].slLoad.Add('No');
  LngData[0].slLoad.Add('As sasha'); //176
  LngData[0].slLoad.Add('Transform mask'); //177
  LngData[0].slLoad.Add('Sector Window'); //178
  LngData[0].slLoad.Add('Window size X'); //179
  LngData[0].slLoad.Add('Window size Y'); //180
  LngData[0].slLoad.Add('Henning window'); //181
  LngData[0].slLoad.Add('Window type'); //182
  LngData[0].slLoad.Add('Apodise'); //183
  LngData[0].slLoad.Add('Cut lines'); //184
  LngData[0].slLoad.Add('Gaussian filter'); //185
  LngData[0].slLoad.Add('Window size'); //186
  LngData[0].slLoad.Add('Make contrast norm'); //187
  LngData[0].slLoad.Add('Grayscale norm'); //188
  LngData[0].slLoad.Add('What is out mask'); //189
  LngData[0].slLoad.Add('Middle'); //190
  LngData[0].slLoad.Add('As is'); //191
  LngData[0].slLoad.Add('Open mask...'); //192
  LngData[0].slLoad.Add('Graph user'); //193
  LngData[0].slLoad.Add('Mark user graph'); //194
  LngData[0].slLoad.Add('Please, mark user graph'); //195
  LngData[0].slLoad.Add('Save user graph...'); //196
  LngData[0].slLoad.Add('Delete mask on open images'); //197
  LngData[0].slLoad.Add('What show behind mask'); //198
  LngData[0].slLoad.Add('Middle'); //199
  LngData[0].slLoad.Add('Minimum'); //200
  LngData[0].slLoad.Add('Maximum'); //201
  LngData[0].slLoad.Add('Grow mask on unwrap'); //202
  LngData[0].bIsLoad := True;
end;

procedure SetRuLangData;
begin
  LngData[1].slLoad := TStringList.Create;
  LngData[1].slLoad.Add('MouthScanner v.2.2');
  LngData[1].slLoad.Add('Файл');
  LngData[1].slLoad.Add('Открыть полутоновое изображение...');
  LngData[1].slLoad.Add('Открыть интерферограмму 1...');
  LngData[1].slLoad.Add('Открыть интерферограмму 2...');
  LngData[1].slLoad.Add('Открыть интерферограмму 3...');
  LngData[1].slLoad.Add('Открыть полутоновое изображение базы...');
  LngData[1].slLoad.Add('Открыть интерферограмму 1 базы...');
  LngData[1].slLoad.Add('Открыть интерферограмму 2 базы...');
  LngData[1].slLoad.Add('Открыть интерферограмму 3 базы...');
  LngData[1].slLoad.Add('Открыть квадратичный коэффициент...');
  LngData[1].slLoad.Add('Открыть линейный коэффициент...');
  LngData[1].slLoad.Add('Открыть постоянный коэффициент...');
  LngData[1].slLoad.Add('Открыть изображения объекта...');
  LngData[1].slLoad.Add('Открыть изображения базы...');
  LngData[1].slLoad.Add('Открыть изображения коэффициентов...');
  LngData[1].slLoad.Add('Сохранить...');
  LngData[1].slLoad.Add('Сохранить вид...');
  LngData[1].slLoad.Add('Выход');
  LngData[1].slLoad.Add('Реконструкция');
  LngData[1].slLoad.Add('Захват изображений');
  LngData[1].slLoad.Add('Обновить изображения');
  LngData[1].slLoad.Add('Выделить объект');
  LngData[1].slLoad.Add('Реконструировать поверхность');
  LngData[1].slLoad.Add('Трехмерная визуализация');
  LngData[1].slLoad.Add('Настройки...');
  LngData[1].slLoad.Add('Окна');
  LngData[1].slLoad.Add('Гистограмма');
  LngData[1].slLoad.Add('Профиль X');
  LngData[1].slLoad.Add('Профиль Y');
  LngData[1].slLoad.Add('Вид');
  LngData[1].slLoad.Add('Объект');
  LngData[1].slLoad.Add('База');
  LngData[1].slLoad.Add('полутоновое изображение');
  LngData[1].slLoad.Add('интерферограмма 1');
  LngData[1].slLoad.Add('интерферограмма 2');
  LngData[1].slLoad.Add('интерферограмма 3');
  LngData[1].slLoad.Add('полутоновое изображение базы');
  LngData[1].slLoad.Add('интерферограмма 1 базы');
  LngData[1].slLoad.Add('интерферограмма 2 базы');
  LngData[1].slLoad.Add('интерферограмма 3 базы');
  LngData[1].slLoad.Add('квадратичный коэффициент');
  LngData[1].slLoad.Add('линейный коэффициент');
  LngData[1].slLoad.Add('постоянный коэффициент');
  LngData[1].slLoad.Add('Область выделения');
  LngData[1].slLoad.Add('Предобработка - полутоновое изображение');
  LngData[1].slLoad.Add('Предобработка - интерферограмма 1');
  LngData[1].slLoad.Add('Предобработка - интерферограмма 2');
  LngData[1].slLoad.Add('Предобработка - интерферограмма 3');
  LngData[1].slLoad.Add('Предобработка - полутоновое изображение базы');
  LngData[1].slLoad.Add('Предобработка - интерферограмма 1 базы');
  LngData[1].slLoad.Add('Предобработка - интерферограмма 2 базы');
  LngData[1].slLoad.Add('Предобработка - интерферограмма 3 базы');
  LngData[1].slLoad.Add('Спектр - полутоновое изображение');
  LngData[1].slLoad.Add('Спектр - интерферограмма 1');
  LngData[1].slLoad.Add('Спектр - интерферограмма 2');
  LngData[1].slLoad.Add('Спектр - интерферограмма 3');
  LngData[1].slLoad.Add('Спектр - полутоновое изображение базы');
  LngData[1].slLoad.Add('Спектр - интерферограмма 1 базы');
  LngData[1].slLoad.Add('Спектр - интерферограмма 2 базы');
  LngData[1].slLoad.Add('Спектр - интерферограмма 3 базы');
  LngData[1].slLoad.Add('Отфильтрованный спектр - интерферограмма 1');
  LngData[1].slLoad.Add('Отфильтрованный спектр - интерферограмма 2');
  LngData[1].slLoad.Add('Отфильтрованный спектр - интерферограмма 3');
  LngData[1].slLoad.Add('Отфильтрованный спектр - интерферограмма 1 базы');
  LngData[1].slLoad.Add('Отфильтрованный спектр - интерферограмма 2 базы');
  LngData[1].slLoad.Add('Отфильтрованный спектр - интерферограмма 3 базы');
  LngData[1].slLoad.Add('Фаза - интерферограмма 1');
  LngData[1].slLoad.Add('Фаза - интерферограмма 2');
  LngData[1].slLoad.Add('Фаза - интерферограмма 3');
  LngData[1].slLoad.Add('Фаза - интерферограмма 1 базы');
  LngData[1].slLoad.Add('Фаза - интерферограмма 2 базы');
  LngData[1].slLoad.Add('Фаза - интерферограмма 3 базы');
  LngData[1].slLoad.Add('Фаза - интерферограмма 1 * Фаза - интерферограмма 1 базы');
  LngData[1].slLoad.Add('Фаза - интерферограмма 2 * Фаза - интерферограмма 2 базы');
  LngData[1].slLoad.Add('Фаза - интерферограмма 3 * Фаза - интерферограмма 3 базы');
  LngData[1].slLoad.Add('Несшитая фаза');
  LngData[1].slLoad.Add('Сшитая фаза');
  LngData[1].slLoad.Add('Постобработка фазы');
  LngData[1].slLoad.Add('Трансформация высоты в мм');
  LngData[1].slLoad.Add('Восстановленная поверхность');
  LngData[1].slLoad.Add('Измененная маска');
  LngData[1].slLoad.Add('Высота в мм');
  LngData[1].slLoad.Add('О программе');
  LngData[1].slLoad.Add('Готово');
  LngData[1].slLoad.Add('Процесс вычислений');
  LngData[1].slLoad.Add('Файл существует. Переписать?');
  LngData[1].slLoad.Add('Внимание');
  LngData[1].slLoad.Add('Поддерживаемый форматы');
  LngData[1].slLoad.Add('Пожалуйста, выделете область объекта');
  LngData[1].slLoad.Add('Мин');
  LngData[1].slLoad.Add('Макс');
  LngData[1].slLoad.Add('Размер по X');
  LngData[1].slLoad.Add('Размер по Y');
  LngData[1].slLoad.Add('Пожалуйста, укажите точку начала сшивки');
  LngData[1].slLoad.Add('Захват');
  LngData[1].slLoad.Add('Предобработка');
  LngData[1].slLoad.Add('Фурье восстановление');
  LngData[1].slLoad.Add('Сшивка фазы');
  LngData[1].slLoad.Add('Постобработка');
  LngData[1].slLoad.Add('Файлы');
  LngData[1].slLoad.Add('Визуализация');
  LngData[1].slLoad.Add('Автоконтраст');
  LngData[1].slLoad.Add('Показывать гистограмму');
  LngData[1].slLoad.Add('Имя файла изображения');
  LngData[1].slLoad.Add('Количество кадров');
  LngData[1].slLoad.Add('Задержка перед захватом');
  LngData[1].slLoad.Add('Директория с изображениями');
  LngData[1].slLoad.Add('Ручное выделение');
  LngData[1].slLoad.Add('Автоматическое выделение');
  LngData[1].slLoad.Add('Область объекта');
  LngData[1].slLoad.Add('Минимальная область');
  LngData[1].slLoad.Add('Гамма коррекция');
  LngData[1].slLoad.Add('Гомоморфная фильтрация');
  LngData[1].slLoad.Add('Вычитание спектров');
  LngData[1].slLoad.Add('НИчего');
  LngData[1].slLoad.Add('Повышение качества');
  LngData[1].slLoad.Add('База');
  LngData[1].slLoad.Add('Энергетическая нормировка');
  LngData[1].slLoad.Add('1 ракурс');
  LngData[1].slLoad.Add('2 ракурса');
  LngData[1].slLoad.Add('3 ракурса');
  LngData[1].slLoad.Add('Количество ракурсов');
  LngData[1].slLoad.Add('Ракурс 1');
  LngData[1].slLoad.Add('Ракурс 2');
  LngData[1].slLoad.Add('Ракурс 3');
  LngData[1].slLoad.Add('Умножать на базу');
  LngData[1].slLoad.Add('Сдвигать максимум');
  LngData[1].slLoad.Add('Убирание клина');
  LngData[1].slLoad.Add('Сшивка фазы');
  LngData[1].slLoad.Add('Ручное выделение');
  LngData[1].slLoad.Add('Автоматическое выделение');
  LngData[1].slLoad.Add('Точка начала сшивки');
  LngData[1].slLoad.Add('Медиан фильтр');
  LngData[1].slLoad.Add('Размер окна');
  LngData[1].slLoad.Add('Фильтр с переменным окном');
  LngData[1].slLoad.Add('Преобразовать в мм');
  LngData[1].slLoad.Add('Оптическая трансформация');
  LngData[1].slLoad.Add('Обрезать по краю');
  LngData[1].slLoad.Add('пикс');
  LngData[1].slLoad.Add('Загрузка');
  LngData[1].slLoad.Add('Сохранение');
  LngData[1].slLoad.Add('Сохранять с маской');
  LngData[1].slLoad.Add('Директория с данными');
  LngData[1].slLoad.Add('Черно белая');
  LngData[1].slLoad.Add('Спектр');
  LngData[1].slLoad.Add('Термовизор');
  LngData[1].slLoad.Add('палитра');
  LngData[1].slLoad.Add('Количество цветов палитры');
  LngData[1].slLoad.Add('4 цвета');
  LngData[1].slLoad.Add('8 цветов');
  LngData[1].slLoad.Add('16 цветов');
  LngData[1].slLoad.Add('32 цвета');
  LngData[1].slLoad.Add('64 цвета');
  LngData[1].slLoad.Add('128 цветов');
  LngData[1].slLoad.Add('256 цветов');
  LngData[1].slLoad.Add('Показывать 1 производную');
  LngData[1].slLoad.Add('Показывать 2 производную');
  LngData[1].slLoad.Add('Показывать верхний порог');
  LngData[1].slLoad.Add('Значение');
  LngData[1].slLoad.Add('Показывать нижний порог');
  LngData[1].slLoad.Add('Показывать результаты');
  LngData[1].slLoad.Add('Директория Smtcam');
  LngData[1].slLoad.Add('Язык');
  LngData[1].slLoad.Add('Угол поворота');
  LngData[1].slLoad.Add('Отражение');
  LngData[1].slLoad.Add('Ось');
  LngData[1].slLoad.Add('Коэффициенты для перевода фазы в мм');
  LngData[1].slLoad.Add('Английский');
  LngData[1].slLoad.Add('Русский');
  LngData[1].slLoad.Add('Сохранить профиль Х...');
  LngData[1].slLoad.Add('Сохранить профиль Y...');
  LngData[1].slLoad.Add('Сохранить гистограмму...');
  LngData[1].slLoad.Add('Сдвигать фазу'); //173
  LngData[1].slLoad.Add('Открыть восстановленную поверхность...');
  LngData[1].slLoad.Add('Не делать'); //175
  LngData[1].slLoad.Add('Как у саши'); //176
  LngData[1].slLoad.Add('Трансформировать маску'); //177
  LngData[1].slLoad.Add('Окно сектором'); //178
  LngData[1].slLoad.Add('Размер окна по Х'); //179
  LngData[1].slLoad.Add('Размер окна по Y'); //180
  LngData[1].slLoad.Add('Окно Хеннинга'); //181
  LngData[1].slLoad.Add('Тип окна'); //182
  LngData[1].slLoad.Add('Аподизация'); //183
  LngData[1].slLoad.Add('Отрезать хвосты'); //184
  LngData[1].slLoad.Add('Гаусс фильтр'); //185
  LngData[1].slLoad.Add('Размер окна'); //186
  LngData[1].slLoad.Add('Выравнивание контраста'); //187
  LngData[1].slLoad.Add('Нормировка на полутоновое'); //188
  LngData[1].slLoad.Add('Что за маской'); //189
  LngData[1].slLoad.Add('Среднее'); //190
  LngData[1].slLoad.Add('Как есть'); //191
  LngData[1].slLoad.Add('Открыть область выделения'); //192
  LngData[1].slLoad.Add('Профиль пользователя'); //193
  LngData[1].slLoad.Add('Провести профиль пользователя'); //194
  LngData[1].slLoad.Add('Пожалуйста, проведите требуемый профиль'); //195
  LngData[1].slLoad.Add('Сохранить профиль пользователя...'); //196
  LngData[1].slLoad.Add('Очищать маску при открытие файлов'); //197
  LngData[1].slLoad.Add('Что показывать за маской'); //198
  LngData[1].slLoad.Add('Среднее'); //199
  LngData[1].slLoad.Add('Минимум'); //200
  LngData[1].slLoad.Add('Максимум'); //201
  LngData[1].slLoad.Add('Увеличивать маску при сшивке'); //202
  LngData[1].bIsLoad := True;
end;

procedure LoadLangData;
var
  iCount : Integer;
  sTemp : AnsiString;
begin
{  sTemp := paramstr(0);
  sTemp := ExtractFilePath(sTemp);
  for iCount := 0 to LngNum - 1 do begin
    LngData[iCount].slLoad := TStringList.Create;
    if FileExists(sTemp + '\' + LngData[iCount].sFileName) then begin
      LngData[iCount].slLoad.LoadFromFile(sTemp + '\' + LngData[iCount].sFileName);
      if LngData[iCount].slLoad.Count < StrNum then
        LngData[iCount].bIsLoad := False
      else LngData[iCount].bIsLoad := True;
    end;
    if (iCount = 0) and (LngData[iCount].bIsLoad = False) then SetEnLangData;
  end;}
  SetEnLangData;
  SetRuLangData;
  for iCount := 0 to LngNum - 1 do
    if not(LngData[iCount].bIsLoad) then case iCount of
      0 : Form1.English1.Visible := False;
      1 : Form1.N26.Visible := False;
    end;
end;

procedure SetLang(iLang : Integer);
var
  iCount : Integer;
begin
  slLang.Free;
  slLang := TStringList.Create;
  slLang.Assign(LngData[iLang].slLoad);
  Form1.ComboBox1.Items.Clear;
  case iLang of
   0 : for iCount := 0 to iDataArrayNum - 1 do
     Form1.ComboBox1.Items.Add(saImageNameEn[iCount]);
   1 : for iCount := 0 to iDataArrayNum - 1 do
     Form1.ComboBox1.Items.Add(saImageNameRu[iCount]);
 end;
end;

procedure SetLangData;
var
  tnTemp : TTreeNode;
  iCount : Integer;
begin
  fTreeParam.TreeView1.Items.Clear;
  tnTemp := fTreeParam.TreeView1.Items.GetFirstNode;
  fTreeParam.TreeView1.Items.Add(tnTemp, slLang.Strings[95]);
  fTreeParam.TreeView1.Items.Add(tnTemp, slLang.Strings[96]);
  fTreeParam.TreeView1.Items.Add(tnTemp, slLang.Strings[97]);
  fTreeParam.TreeView1.Items.Add(tnTemp, slLang.Strings[98]);
  fTreeParam.TreeView1.Items.Add(tnTemp, slLang.Strings[99]);
  fTreeParam.TreeView1.Items.Add(tnTemp, slLang.Strings[100]);
  fTreeParam.TreeView1.Items.Add(tnTemp, slLang.Strings[101]);
  fTreeParam.Caption := slLang.Strings[25];
  FormLineX.Caption := slLang.Strings[28];
  FormLineY.Caption := slLang.Strings[29];
  Form5.Caption := slLang.Strings[193];
  Form1.ToolButton1.Hint := slLang.Strings[13];
  Form1.ToolButton2.Hint := slLang.Strings[16];
  Form1.ToolButton3.Hint := slLang.Strings[25];
  Form1.ToolButton5.Hint := slLang.Strings[22];
  Form1.ToolButton6.Hint := slLang.Strings[23];
  Form1.ToolButton11.Hint := slLang.Strings[83];
  Form1.ToolButton10.Hint := slLang.Strings[21];
  Form1.ToolButton4.Hint := slLang.Strings[20];
  Form1.ToolButton12.Hint := slLang.Strings[24];
  Form1.Caption := slLang.Strings[0]{ + ' | |'};
  Form1.StatusBar1.Panels[0].Text := slLang.Strings[84];
  Form1.N1.Caption := slLang.Strings[1];
  Form1.Openrealimage1.Caption := slLang.Strings[2];
  Form1.Openinterferogram11.Caption := slLang.Strings[3];
  Form1.Openinteferogram21.Caption := slLang.Strings[4];
  Form1.Openinterferogram31.Caption := slLang.Strings[5];
  Form1.Openbaserealimage1.Caption := slLang.Strings[6];
  Form1.Openbaseinterferogram11.Caption := slLang.Strings[7];
  Form1.Openbaseinterferogram21.Caption := slLang.Strings[8];
  Form1.Openbaseinterferogram31.Caption := slLang.Strings[9];
  Form1.Openquadratickoeff1.Caption := slLang.Strings[10];
  Form1.Openlinearkoeff1.Caption := slLang.Strings[11];
  Form1.Openconstantkoeff1.Caption := slLang.Strings[12];
  Form1.N5.Caption := slLang.Strings[13];
  Form1.Openbaseimages1.Caption := slLang.Strings[14];
  Form1.Openkoeffimages1.Caption := slLang.Strings[15];
  Form1.N6.Caption := slLang.Strings[16];
  Form1.Saveview1.Caption := slLang.Strings[17];
  Form1.N7.Caption := slLang.Strings[18];
  Form1.N2.Caption := slLang.Strings[19];
  Form1.N12.Caption := slLang.Strings[20];
  Form1.N8.Caption := slLang.Strings[21];
  Form1.N13.Caption := slLang.Strings[22];
  Form1.N14.Caption := slLang.Strings[23];
  Form1.N3DView1.Caption := slLang.Strings[24];
  Form1.N15.Caption := slLang.Strings[25];
  Form1.Windows1.Caption := slLang.Strings[26];
  Form1.Histogram1.Caption := slLang.Strings[27];
  Form1.GraphX1.Caption := slLang.Strings[28];
  Form1.GraphY1.Caption := slLang.Strings[29];
  Form1.N3.Caption := slLang.Strings[30];
  Form1.Object1.Caption := slLang.Strings[31];
  Form1.Base1.Caption := slLang.Strings[32];
  Form1.N17.Caption := slLang.Strings[33];
  Form1.Realimage1.Caption := slLang.Strings[33];
  Form1.Realimage4.Caption := slLang.Strings[33];
  Form1.N18.Caption := slLang.Strings[34];
  Form1.Interferogram11.Caption := slLang.Strings[34];
  Form1.N22.Caption := slLang.Strings[35];
  Form1.Interferogram21.Caption := slLang.Strings[35];
  Form1.Interferogram24.Caption := slLang.Strings[36];
  Form1.Interferogram24.Caption := slLang.Strings[36];
  Form1.Realimage2.Caption := slLang.Strings[37];
  Form1.Realimage3.Caption := slLang.Strings[37];
  Form1.Interferogram12.Caption := slLang.Strings[38];
  Form1.Interferogram13.Caption := slLang.Strings[38];
  Form1.Interferogram22.Caption := slLang.Strings[39];
  Form1.Interferogram23.Caption := slLang.Strings[39];
  Form1.Interferogram31.Caption := slLang.Strings[40];
  Form1.Interferogram32.Caption := slLang.Strings[40];
  Form1.Quadratickoeff1.Caption := slLang.Strings[41];
  Form1.Linearkoeff1.Caption := slLang.Strings[42];
  Form1.Constantkoeff1.Caption := slLang.Strings[43];
  Form1.Mask1.Caption := slLang.Strings[44];
  Form1.Preprocess1.Caption := slLang.Strings[45];
  Form1.Preprocess2.Caption := slLang.Strings[46];
  Form1.Preprocess3.Caption := slLang.Strings[47];
  Form1.Preprocess7.Caption := slLang.Strings[48];
  Form1.Preprocess6.Caption := slLang.Strings[49];
  Form1.Preprocess4.Caption := slLang.Strings[50];
  Form1.Preprocess5.Caption := slLang.Strings[51];
  Form1.Preprocess12.Caption := slLang.Strings[52];  
  Form1.Spectrum1.Caption := slLang.Strings[53];
  Form1.Spectrum2.Caption := slLang.Strings[54];
  Form1.Spectrum3.Caption := slLang.Strings[55];
  Form1.Spectrum7.Caption := slLang.Strings[56];
  Form1.Spectrum6.Caption := slLang.Strings[57];
  Form1.Spectrum4.Caption := slLang.Strings[58];
  Form1.Spectrum5.Caption := slLang.Strings[59];
  Form1.Spectrum12.Caption := slLang.Strings[60];
  Form1.Filteredspectrum1.Caption := slLang.Strings[61];
  Form1.Filteredspectrum2.Caption := slLang.Strings[62];
  Form1.Filteredspectrum6.Caption := slLang.Strings[63];
  Form1.Filteredspectrum3.Caption := slLang.Strings[64];
  Form1.Filteredspectrum4.Caption := slLang.Strings[65];
  Form1.Filteredspectrum5.Caption := slLang.Strings[66];
  Form1.Phase1.Caption := slLang.Strings[67];
  Form1.Phase2.Caption := slLang.Strings[68];
  Form1.Phase6.Caption := slLang.Strings[69];
  Form1.Phase3.Caption := slLang.Strings[70];
  Form1.Phase4.Caption := slLang.Strings[71];
  Form1.Phase5.Caption := slLang.Strings[72];  
  Form1.Phasemulbasephase1.Caption := slLang.Strings[73];
  Form1.Phasemulbasephase2.Caption := slLang.Strings[74];
  Form1.Phasemulbasephase3.Caption := slLang.Strings[75];
  Form1.N19.Caption := slLang.Strings[76];
  Form1.Unwrappedphase1.Caption := slLang.Strings[77];
  Form1.Postprocessedphase1.Caption := slLang.Strings[78];
  Form1.transformedmap1.Caption := slLang.Strings[79];
  Form1.N20.Caption := slLang.Strings[80];
  Form1.Mapinmm1.Caption := slLang.Strings[82];
  Form1.Koeffsforphasetomap1.Caption := slLang.Strings[167];
  Form1.N4.Caption := slLang.Strings[83];
  Form1.Language1.Caption := slLang.Strings[163];
  FormHisto.Caption := slLang.Strings[27];
  Form1.English1.Caption := slLang.Strings[168];
  Form1.N26.Caption := slLang.Strings[169];
  Form1.SavegraphX1.Caption := slLang.Strings[170];
  Form1.SavegraphY1.Caption := slLang.Strings[171];
  Form1.Savehistogram1.Caption := slLang.Strings[172];
  Form1.Openreconstructedsurface1.Caption := slLang.Strings[174];
  Form1.Openmask1.Caption := slLang.Strings[192];
  Form1.Graphuser1.Caption := slLang.Strings[193];
  Form1.MarkuserGraph1.Caption := slLang.Strings[194];
  Form1.Saveusergraph1.Caption := slLang.Strings[196];

  Form1.Label1.Caption := slLang.Strings[30];
end;

begin
  LngData[0].bIsLoad := False;
  LngData[0].sName := 'English';
  LngData[0].sFileName := 'english.lng';
  LngData[1].bIsLoad := False;
  LngData[1].sName := 'Русский';
  LngData[1].sFileName := 'russian.lng';
end.
