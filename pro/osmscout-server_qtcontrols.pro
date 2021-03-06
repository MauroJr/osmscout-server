# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = osmscout-server

QT += core network sql xml quick gui positioning dbus

CONFIG += c++11 object_parallel_to_source

CONFIG += link_pkgconfig

# selection of backends
!disable_mapnik {
    CONFIG += use_mapnik
}

!disable_osmscout {
    CONFIG += use_osmscout
}

!disable_valhalla {
    CONFIG += use_valhalla
}

!disable_systemd {
    CONFIG += use_systemd
}

# libosmscout settings
!use_map_cairo {
    CONFIG += use_map_qt
}
#CONFIG += use_map_cairo

isEmpty(PREFIX) {
 PREFIX = /usr/local
}

# installs
styles.files = styles
styles.path = $${PREFIX}/share/$${TARGET}
INSTALLS += styles

data.files = data
data.path = $${PREFIX}/share/$${TARGET}
INSTALLS += data

target.path = $$PREFIX/bin
INSTALLS += target

icons108.path = $$PREFIX/share/icons/hicolor/108x108/apps
icons108.extra = cp icons/108x108/harbour-osmscout-server.png $$PREFIX/share/icons/hicolor/108x108/apps/$${TARGET}.png
icons108.files = icons/108x108/$${TARGET}.png
INSTALLS += icons108
icons128.path = $$PREFIX/share/icons/hicolor/128x128/apps
icons128.extra = cp icons/128x128/harbour-osmscout-server.png $$PREFIX/share/icons/hicolor/128x128/apps/$${TARGET}.png
icons128.files = icons/128x128/$${TARGET}.png
INSTALLS += icons128
icons256.path = $$PREFIX/share/icons/hicolor/256x256/apps
icons256.extra = cp icons/256x256/harbour-osmscout-server.png $$PREFIX/share/icons/hicolor/256x256/apps/$${TARGET}.png
icons256.files = icons/256x256/$${TARGET}.png
INSTALLS += icons256
icons86.path = $$PREFIX/share/icons/hicolor/86x86/apps
icons86.extra = cp icons/86x86/harbour-osmscout-server.png $$PREFIX/share/icons/hicolor/86x86/apps/$${TARGET}.png
icons86.files = icons/86x86/$${TARGET}.png
INSTALLS += icons86

appdata.path =$$PREFIX/share/metainfo
appdata.files = packaging/osmscout-server.appdata.xml
INSTALLS += appdata

# defines
DEFINES += APP_VERSION=\\\"$$VERSION\\\"
DEFINES += IS_QTCONTROLS_QT

# default prefix for data
DEFINES += DEFAULT_DATA_PREFIX=\\\"$${PREFIX}/share/$${TARGET}/\\\"

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

SOURCES += src/dbmaster.cpp \
    src/main.cpp \
    src/requestmapper.cpp \
    src/appsettings.cpp \
    src/dbmaster_route.cpp \
    src/dbmaster_search.cpp \
    src/dbmaster_map.cpp \
    src/osmscout-server_console.cpp \
    src/searchresults.cpp \
    src/infohub.cpp \
    src/rollinglogger.cpp \
    src/consolelogger.cpp \
    src/routingforhuman.cpp \
    src/geomaster.cpp \
    src/config.cpp \
    src/mapmanager.cpp \
    src/filedownloader.cpp \
    src/mapmanagerfeature.cpp \
    src/mapmanager_urlcollection.cpp \
    src/mapmanagerfeature_packtaskworker.cpp \
    src/mapnikmaster.cpp \ 
    src/modulechecker.cpp \
    src/valhallamaster.cpp \
    src/mapmanager_deleterthread.cpp \
    src/systemdservice.cpp \
    src/util.cpp \
    src/mapboxglmaster.cpp \
    src/valhallamapmatcher.cpp \
    src/valhallamapmatcherdbus.cpp \
    src/valhallamapmatcherdbusadaptor.cpp
    
OTHER_FILES += \
    osmscout-server.desktop

include(src/uhttp/uhttp.pri)
include(src/fileselector/fileselector.pri)
include(src/geocoder-nlp/geocoder-nlp.pri)

HEADERS += \
    src/dbmaster.h \
    src/requestmapper.h \
    src/appsettings.h \
    src/config.h \
    src/searchresults.h \
    src/infohub.h \
    src/rollinglogger.h \
    src/consolelogger.h \
    src/routingforhuman.h \
    src/geomaster.h \
    src/mapmanager.h \
    src/filedownloader.h \
    src/mapmanagerfeature.h \
    src/mapmanager_urlcollection.h \
    src/mapmanagerfeature_packtaskworker.h \
    src/mapnikmaster.h \
    src/modulechecker.h \
    src/valhallamaster.h \
    src/mapmanager_deleterthread.h \
    src/systemdservice.h \
    src/util.hpp \
    src/mapboxglmaster.h \
    src/valhallamapmatcher.h \
    src/valhallamapmatcherdbus.h \
    src/valhallamapmatcherdbusadaptor.h
    
use_osmscout {
    DEFINES += USE_OSMSCOUT

    use_map_qt {
        DEFINES += USE_OSMSCOUT_MAP_QT
        QT += gui
        LIBS += -losmscout_map_qt
    }

    use_map_cairo {
        DEFINES += USE_OSMSCOUT_MAP_CAIRO
        LIBS += -losmscout_map_cairo
        PKGCONFIG += pango cairo
    }

    LIBS += -losmscout_map -losmscout
}

# geocoder-nlp is enabled always
DEFINES += GEOCODERNLP_ALIASFILE=\\\"$${PREFIX}/share/$${TARGET}/data/geocoder-npl-tag-aliases.json\\\"

# mapbox gl is enabled always
DEFINES += MAPBOXGL_STYLEDIR=\\\"$${PREFIX}/share/$${TARGET}/styles/mapboxgl\\\"

use_mapnik {
    DEFINES += USE_MAPNIK
    #DEFINES += MAPNIK_FONTS_DIR=\\\"$$system(mapnik-config --fonts)\\\"
    DEFINES += MAPNIK_FONTS_DIR=\\\"$${PREFIX}/share/osmscout-server-fonts/fonts\\\"
    DEFINES += MAPNIK_INPUT_PLUGINS_DIR=\\\"$$system(mapnik-config --input-plugins)\\\"
    LIBS += -lmapnik -licuuc
}

use_valhalla {
    DEFINES += USE_VALHALLA
    DEFINES += VALHALLA_CONFIG_TEMPLATE=\\\"$${PREFIX}/share/$${TARGET}/data/valhalla.json\\\"
    PKGCONFIG += libvalhalla
}

use_curl {
    DEFINES += USE_LIBCURL
    PKGCONFIG += libcurl
}

use_systemd {
    DEFINES += USE_SYSTEMD
    PKGCONFIG += libsystemd
}

LIBS += -L$${PREFIX}/lib -lmarisa -lkyotocabinet -lz -lsqlite3

QMAKE_CXXFLAGS += -fopenmp
LIBS += -fopenmp

RESOURCES += qml_qtcontrols.qrc

CONFIG(release, debug|release) {
    DEFINES += QT_NO_WARNING_OUTPUT QT_NO_DEBUG_OUTPUT
}

