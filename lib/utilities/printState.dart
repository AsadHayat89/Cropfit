import 'package:pdf/widgets.dart' as pw;

class PrintState{
  static var page1 = pw.Column(
    children: [
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.center,
        children:[
          pw.Text('Cropfit Investment Contract', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18)),
        ]
      ),
      pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children:[
            pw.Text('Cropfit (Pvt) Ltd. Pakistan\n'),
          ]
      ),
      pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          children:[
            pw.Expanded(
              child: pw.Text('\n\n1. If the cultivated variety is cured in the sun under plastic cover, the cover must be at 50-70 cm from the ground so that the '
                  'curing shed will be open from all sides.\n\n2. The farmer undertakes to use only the seeds or the plants from selected seeds that '
                  'are approved by the first manipulator or the NTB. Also the farmer is obliged not to use chemicals which are forbidden for '
                  'the crop (organic chlorides, etc), and to use strictly only the chemicals approved for tobacco cultivation by the agronomists of '
                  'the NTB or the buyers, and follow the instructions on the manufacturer\'s label.\n\n4. The first buyer-manipulator has the right, '
                  'within the period of validity of this contract, to carry out, in the presence of the farmer, control checks regarding the '
                  'observance of the obligations that derive from this contract and to take samples against reimbursement.\n\n5. The farmer undertakes the '
                  'obligation to deliver to the first buyer all the crop yielded from the present contracted area that meets the minimum '
                  'quality characteristics, is clean, pure, healthy, marketable and free from defects that are named in Annex 11 of Community '
                  'Regulation 3478/92 and does not exceed the maximum quota confirmed, as stated in the above Article 1 of the present contract. '
                  'Also, the farmer is not allowed to contract with any other buyer to cultivate in the same or different fields the crop '
                  'variety that is the subject of the present contract. Except in case of unexpected incidents, the farmer has to deliver to '
                  'the first buyer-manipulator the whole of his yield before ........ If in any case the delivery is not completed '
                  'before 15 May 1994, the farmer loses the Community subsidy.\n\n6. The first buyer-manipulator undertakes the obligation, '
                  'within the limit of the maximum quota as stated in Article 1, to collect the whole yield, harvested from the present area, '
                  'before............ (same date as Article 5 para 2).In the case of delay of delivery after 15 May 2023 because of farmer\'s '
                  'culpability, the first buyer-manipulator is released from the obligation of compulsory payment of the subsidy, or in case of '
                  'delay of collection because of first buyer-manipulator\'s culpability, the latter bears the cost of the subsidy.', softWrap: true, tightBounds: false, textAlign: pw.TextAlign.justify)
            ),
          ]
      ),
    ]
  );
  static String printText =
      'Sample Contract'
  ;
}