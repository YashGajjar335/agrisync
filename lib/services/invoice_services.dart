import 'dart:io';
import 'package:agrisync/model/order.dart';
import 'package:agrisync/model/product.dart';
import 'package:agrisync/model/user_address.dart';
import 'package:agrisync/services/agri_mart_service_user.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class InvoiceServices {
  static Future<File> saveInvoice(
      {required String invoiceName, required pw.Document pdf}) async {
    final root = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    final file = File('${root!.path}/$invoiceName');
    await file.writeAsBytes(await pdf.save());
    debugPrint("${root.path}/$invoiceName");
    return file;
  }

  static Future<void> openInvoice(File file) async {
    final path = file.path;
    await OpenFile.open(path);
  }

  static Future<File> generateInvoice({required OrderModel orderModel}) async {
    final pdf = pw.Document();

    // Load custom font
    final ByteData fontData =
        await rootBundle.load('assets/font/Roboto-VariableFont_wdth,wght.ttf');
    final Uint8List fontBytes = fontData.buffer.asUint8List();
    final pw.Font robotoFont = pw.Font.ttf(fontBytes.buffer.asByteData());

    // Load logo image
    final ByteData bytes = await rootBundle.load('assets/app_logo_half.JPG');
    final Uint8List logo = bytes.buffer.asUint8List();

    // List<Products> productList = [];

    // orderModel.items.forEach((product, quantity) async {
    //   Products? products =
    //       await AgriMartServiceUser.instance.getProduct(product);
    //   productList.add(products!);
    // });

    UserAddress? userAddress =
        await AgriMartServiceUser.instance.getUserAddress();

    // final userDetail = await AuthServices.instance.getCurrentUserDetail();

    List<List<String>> tableData = []; // Table rows
    // ignore: unused_local_variable
    double subtotal = 0;

    for (var entry in orderModel.items.entries) {
      Products? product =
          await AgriMartServiceUser.instance.getProduct(entry.key);
      if (product != null) {
        double totalPrice = product.price * entry.value;
        subtotal += totalPrice;
        tableData.add([
          product.productName,
          entry.value.toString(),
          ' ${product.price.toStringAsFixed(2)}',
          ' ${totalPrice.toStringAsFixed(2)}',
        ]);
      }
    }

    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(24),
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header with logo and invoice details
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Container(
                      width: 60,
                      height: 60,
                      padding: const pw.EdgeInsets.all(8),
                      decoration: pw.BoxDecoration(
                        color: PdfColors.white,
                        border: pw.Border.all(color: PdfColors.grey, width: 2),
                        borderRadius: pw.BorderRadius.circular(10),
                        boxShadow: const [
                          pw.BoxShadow(
                            color: PdfColors.grey300,
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: pw.Image(
                        pw.MemoryImage(logo),
                        fit: pw.BoxFit.cover,
                      ),
                    ),
                    pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text("AgriSync",
                              style: pw.TextStyle(
                                  font: robotoFont,
                                  fontSize: 26,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.SizedBox(height: 5),
                          pw.Text(
                              "Synchronization of various agricultural activities  ",
                              style: pw.TextStyle(
                                  font: robotoFont,
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold)),
                        ]),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text('Invoice',
                            style: pw.TextStyle(
                                font: robotoFont,
                                fontSize: 24,
                                fontWeight: pw.FontWeight.bold)),
                        pw.Text(
                            'Date: ${simplyDateFormat(time: orderModel.orderDate, dateOnly: true)}',
                            style: pw.TextStyle(font: robotoFont)),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),

                // User Details
                pw.Text('Customer Details',
                    style: pw.TextStyle(
                        font: robotoFont,
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold)),
                pw.Text(userAddress!.fullName,
                    style: pw.TextStyle(font: robotoFont)),
                pw.Text(
                    '${userAddress.flatNumber}, ${userAddress.streetRoad}, ${userAddress.street}',
                    style: pw.TextStyle(font: robotoFont)),
                pw.Text(
                    '${userAddress.city} - ${userAddress.postalCode}, ${userAddress.state}',
                    style: pw.TextStyle(font: robotoFont)),
                pw.Text('Phone: ${userAddress.phoneNumber}',
                    style: pw.TextStyle(font: robotoFont)),
                pw.SizedBox(height: 20),

                // ignore: deprecated_member_use
                pw.Table.fromTextArray(
                  headers: ['Product', 'Quantity', 'Price (₹)', 'Total (₹)'],
                  data: tableData,
                  border: pw.TableBorder.all(),
                  headerStyle: pw.TextStyle(
                      font: robotoFont, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 20),

                // Total Amount
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Subtotal:',
                        style: pw.TextStyle(
                            font: robotoFont, fontWeight: pw.FontWeight.bold)),
                    pw.Text('₹ ${subtotal.toStringAsFixed(2)}',
                        style: pw.TextStyle(font: robotoFont)),
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Tax (0%):',
                        style: pw.TextStyle(
                            font: robotoFont, fontWeight: pw.FontWeight.bold)),
                    pw.Text('₹ 0', style: pw.TextStyle(font: robotoFont)),
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Total: ',
                        style: pw.TextStyle(
                            font: robotoFont,
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold)),
                    pw.Text('₹ ${orderModel.totalAmount.toStringAsFixed(2)}',
                        style: pw.TextStyle(
                            font: robotoFont,
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold)),
                  ],
                ),

                pw.SizedBox(height: 30),

                pw.Divider(),
                pw.Text('Thank you for your purchase!',
                    style: pw.TextStyle(
                        font: robotoFont, fontWeight: pw.FontWeight.bold)),
              ],
            ),
          );
        },
      ),
    );

    return saveInvoice(invoiceName: "invoice.pdf", pdf: pdf);
  }
}
