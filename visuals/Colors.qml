// Generated with Matugen
pragma Singleton
import QtQuick

QtObject {

    readonly property bool darkTheme: true 
    readonly property string sourceImage: "/home/utriainenj/themes/wide/trees.jpg"

    readonly property color clrBackground: "#11140e"

    readonly property color clrError: "#ffb4ab"

    readonly property color clrErrorContainer: "#93000a"

    readonly property color clrInverseOnSurface: "#2e312a"

    readonly property color clrInversePrimary: "#48672e"

    readonly property color clrInverseSurface: "#e2e3d9"

    readonly property color clrOnBackground: "#e2e3d9"

    readonly property color clrOnError: "#690005"

    readonly property color clrOnErrorContainer: "#ffdad6"

    readonly property color clrOnPrimary: "#1b3704"

    readonly property color clrOnPrimaryContainer: "#c9eea7"

    readonly property color clrOnPrimaryFixed: "#0c2000"

    readonly property color clrOnPrimaryFixedVariant: "#314e19"

    readonly property color clrOnSecondary: "#29341f"

    readonly property color clrOnSecondaryContainer: "#dae7c9"

    readonly property color clrOnSecondaryFixed: "#141e0c"

    readonly property color clrOnSecondaryFixedVariant: "#3f4a34"

    readonly property color clrOnSurface: "#e2e3d9"

    readonly property color clrOnSurfaceVariant: "#c4c8ba"

    readonly property color clrOnTertiary: "#003736"

    readonly property color clrOnTertiaryContainer: "#bbece9"

    readonly property color clrOnTertiaryFixed: "#00201f"

    readonly property color clrOnTertiaryFixedVariant: "#1e4e4d"

    readonly property color clrOutline: "#8e9286"

    readonly property color clrOutlineVariant: "#44483e"

    readonly property color clrPrimary: "#aed18d"

    readonly property color clrPrimaryContainer: "#314e19"

    readonly property color clrPrimaryFixed: "#c9eea7"

    readonly property color clrPrimaryFixedDim: "#aed18d"

    readonly property color clrScrim: "#000000"

    readonly property color clrSecondary: "#becbae"

    readonly property color clrSecondaryContainer: "#3f4a34"

    readonly property color clrSecondaryFixed: "#dae7c9"

    readonly property color clrSecondaryFixedDim: "#becbae"

    readonly property color clrShadow: "#000000"

    readonly property color clrSourceColor: "#131b0c"

    readonly property color clrSurface: "#11140e"

    readonly property color clrSurfaceBright: "#373a33"

    readonly property color clrSurfaceContainer: "#1e211a"

    readonly property color clrSurfaceContainerHigh: "#282b24"

    readonly property color clrSurfaceContainerHighest: "#33362e"

    readonly property color clrSurfaceContainerLow: "#1a1d16"

    readonly property color clrSurfaceContainerLowest: "#0c0f09"

    readonly property color clrSurfaceDim: "#11140e"

    readonly property color clrSurfaceTint: "#aed18d"

    readonly property color clrSurfaceVariant: "#44483e"

    readonly property color clrTertiary: "#a0cfcd"

    readonly property color clrTertiaryContainer: "#1e4e4d"

    readonly property color clrTertiaryFixed: "#bbece9"

    readonly property color clrTertiaryFixedDim: "#a0cfcd"

    function hoverTone(baseColor, strength) {
        strength = strength || 1.20

        if (darkTheme) { return Qt.lighter(baseColor, strength) }
        else { return Qt.darker(baseColor, strength) }
    }
}
