$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing
$canvas = [Drawing.Bitmap]::new(1800, 560)
$g = [Drawing.Graphics]::FromImage($canvas)
$g.SmoothingMode = [Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [Drawing.Text.TextRenderingHint]::AntiAliasGridFit
function Brush([string]$hex) { [Drawing.SolidBrush]::new([Drawing.ColorTranslator]::FromHtml($hex)) }
function Label([string]$text, [single]$size, [single]$x, [single]$y, [string]$color, [bool]$bold = $false) {
    $style = [Drawing.FontStyle]::Regular
    if ($bold) { $style = [Drawing.FontStyle]::Bold }
    $font = [Drawing.Font]::new('Segoe UI', $size, $style, [Drawing.GraphicsUnit]::Pixel)
    $ink = Brush $color
    $g.DrawString($text, $font, $ink, $x, $y)
    $font.Dispose(); $ink.Dispose()
}
$bg = [Drawing.Drawing2D.LinearGradientBrush]::new([Drawing.Point]::new(0,0), [Drawing.Point]::new(1800,560), [Drawing.ColorTranslator]::FromHtml('#101625'), [Drawing.ColorTranslator]::FromHtml('#24213F'))
$g.FillRectangle($bg, 0, 0, 1800, 560)
$grid = [Drawing.Pen]::new([Drawing.Color]::FromArgb(22, 191, 178, 231), 1)
for ($x=1090; $x -lt 1750; $x+=52) { $g.DrawLine($grid, $x, 60, $x, 475) }
for ($y=60; $y -lt 480; $y+=52) { $g.DrawLine($grid, 1090, $y, 1740, $y) }
$accent = Brush '#BCA7F5'
$g.FillRectangle($accent, 76, 84, 6, 350)
Label 'BAMSI / MENDEZ' 23 108 82 '#BCA7F5' $true
Label 'Datos, modelos' 76 101 145 '#F7F5FF' $true
Label 'y preguntas.' 76 101 229 '#F7F5FF' $true
Label 'COMPUTACION  /  ESTADISTICA  /  MATEMATICAS' 23 109 354 '#C7C7DB'
Label 'Universidad Nacional de Colombia  /  Manizales' 22 109 403 '#A5ADC5'
# Abstract overlapping curves: a visual motif, not research results.
foreach ($layer in 0..2) {
    $hex = @('#BCA7F5','#60D9C5','#6F87CD')[$layer]
    $pen = [Drawing.Pen]::new([Drawing.ColorTranslator]::FromHtml($hex), 4)
    $pts = [Collections.Generic.List[Drawing.PointF]]::new()
    for ($i=0; $i -le 240; $i++) {
        $xx = 1110 + $i * 2.5
        $z = ($i - (108 + 23 * $layer)) / (35 + 7 * $layer)
        $yy = 418 - (260 - $layer * 48) * [Math]::Exp(-0.5 * $z * $z)
        $pts.Add([Drawing.PointF]::new($xx, $yy))
    }
    $g.DrawLines($pen, $pts.ToArray())
    $pen.Dispose()
}
Label 'LEARN  /  MODEL  /  QUESTION' 18 1170 461 '#BCA7F5'
$output = Join-Path $PSScriptRoot '..\assets\profile-banner.png'
$canvas.Save([IO.Path]::GetFullPath($output), [Drawing.Imaging.ImageFormat]::Png)
$g.Dispose(); $canvas.Dispose(); $bg.Dispose(); $grid.Dispose(); $accent.Dispose()
Write-Output 'Created assets/profile-banner.png (1800 x 560).'
