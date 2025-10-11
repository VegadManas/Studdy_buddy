import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// Removed 'Color primaryColor' argument, as the color can be accessed via Theme.
void showPdfViewerDialog(BuildContext context, String filePath, String title) {
  showDialog(
    context: context,
    // Use theme colors for barrier
    barrierColor: Theme.of(context).colorScheme.scrim.withOpacity(0.5),
    builder: (context) {
      final colorScheme = Theme.of(context).colorScheme;

      Widget pdfWidget;
      try {
        // Handle asset vs file path for PDF Viewer
        pdfWidget = filePath.startsWith("lib/")
            ? SfPdfViewer.asset(filePath)
            : SfPdfViewer.file(File(filePath));
      } catch (e) {
        pdfWidget = Center(
          child: Text(
            "Error loading PDF.",
            // Use error color for visibility
            style: TextStyle(color: colorScheme.error),
          ),
        );
      }

      return Dialog(
        // Dialog background uses theme surface
        backgroundColor: colorScheme.surface,
        insetPadding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 24,
                    right: 24,
                    bottom: 8,
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      // Title text color uses theme onSurface
                      color: colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: constraints.maxWidth * 0.95,
                  height: constraints.maxHeight * 0.70,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: pdfWidget,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          // Button background uses theme primary
                          backgroundColor: colorScheme.primary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Close",
                          // Button text color uses theme onPrimary
                          style: TextStyle(color: colorScheme.onPrimary),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
