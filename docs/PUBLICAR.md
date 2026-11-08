# Publicar y mantener el perfil

El perfil público se presenta en `README.md`. `README.en.md` contiene la versión en inglés. La portada está en `assets/profile-banner.png` y se puede regenerar en Windows con:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\New-ProfileBanner.ps1
```

## Subir esta versión

El README de perfil debe estar en la raíz de un repositorio **público** llamado exactamente **BamsiMendez**, dentro de la cuenta **BamsiMendez**.

La opción más directa para esta carpeta descargada es abrir ese repositorio en GitHub, elegir **Add file → Upload files** y arrastrar `README.md`, `README.en.md`, las carpetas `assets`, `scripts` y `docs`, y los archivos `.gitignore` y `.gitattributes`. Confirma el commit. No subas `.local-backup`.

Si prefieres Git, clona el repositorio existente en una carpeta nueva. Estos comandos parten de tu carpeta de usuario, para evitar ejecutar Git dentro de System32:

```powershell
Set-Location $env:USERPROFILE
git clone https://github.com/BamsiMendez/BamsiMendez.git BamsiMendez-profile
Set-Location .\BamsiMendez-profile
$profileSource = 'C:\Users\sivam\Downloads\BamsiMendez-main\BamsiMendez-main'
Copy-Item -LiteralPath (Join-Path $profileSource 'README.md'), (Join-Path $profileSource 'README.en.md'), (Join-Path $profileSource '.gitignore'), (Join-Path $profileSource '.gitattributes') -Destination . -Force
Copy-Item -LiteralPath (Join-Path $profileSource 'assets'), (Join-Path $profileSource 'scripts'), (Join-Path $profileSource 'docs') -Destination . -Recurse -Force
git diff --stat
git add README.md README.en.md assets scripts docs .gitignore .gitattributes
git commit -m "Refresh profile with research projects and bilingual presentation"
git push
```

Usa un nombre de destino libre para el clon. Si `BamsiMendez-profile` ya existe, entra en él y revisa su estado antes de copiar los archivos. Si el repositorio aún no existe, créalo público en GitHub y añade un README antes de clonarlo.

## Ajustes de la página de perfil

Bio sugerida (lista para copiar):

> Estudiante de Ciencias de la Computación @ UNAL Manizales | Machine learning, inferencia bayesiana y computación científica.

Ubicación: **Manizales, Colombia**. Añade tu LinkedIn en los enlaces sociales.

En **Customize your pins**, destaca primero el proyecto de PINNs. Añade Chicago y tu primer póster cuando sus versiones públicas estén listas; después, selecciona trabajos distintos que aporten algo más que ejercicios sueltos. Tres proyectos bien documentados son suficientes para comenzar.

## Mantenimiento

- El enlace de PINNs procede del repositorio que ya compartiste. No fue posible comprobar su disponibilidad en línea durante esta edición.
- LinkedIn y Kaggle conservan las direcciones del README original; revisa que sigan siendo tus perfiles públicos.
- Chicago está descrito sin enlace porque no se pudo confirmar la publicación del repositorio. Añádelo en ambos idiomas cuando esté disponible.
- Actualiza los dos README cuando cambien los proyectos o tus intereses.
- Las herramientas enumeradas describen tu experiencia de trabajo, sin atribuir niveles de dominio ni certificaciones.
- Las curvas de la portada son decorativas: no representan resultados de tus investigaciones.
- Las copias originales están en `.local-backup`, excluida de Git. Los antiguos banners de la raíz se conservan por compatibilidad, pero el nuevo README usa únicamente `assets/profile-banner.png`.
