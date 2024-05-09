import 'package:flutter/material.dart';
import 'package:flutter_app_examfinal_gsa/models/provider_model.dart';

class ProveedoresCard extends StatelessWidget {
  final List_provider proveedor;
  const ProveedoresCard({Key? key, required this.proveedor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        margin: const EdgeInsets.only(top: 2, bottom: 0),
        width: double.infinity,
        height: 102,
        decoration: _cardDecorations(),
        child: Stack(alignment: Alignment.bottomLeft, children: [
          _ProductDetails(prov: proveedor),
          if (proveedor.ProveedorState == 'bloqueado')
            Positioned(top: 0, left: 0, child: _State(prov: proveedor))
        ]),
      ),
    );
  }

  BoxDecoration _cardDecorations() =>
      BoxDecoration(color: Colors.white, boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(0, 0, 0, 0),
          offset: Offset(0, 5),
          blurRadius: 10,
        )
      ]);
}

class _State extends StatelessWidget {
  final List_provider prov;

  const _State({Key? key, required this.prov}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(prov.ProveedorName,
                style: TextStyle(fontSize: 20, color: Colors.white))),
      ),
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.red,
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final List_provider prov;

  const _ProductDetails({Key? key, required this.prov}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 80,
        decoration: _boxDecorations(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              prov.ProveedorName,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              prov.ProveedorState,
              style: TextStyle(fontSize: 15, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _boxDecorations() => const BoxDecoration(
        color: Colors.orange,
      );
}
