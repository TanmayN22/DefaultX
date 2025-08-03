// lib/app/modules/applicant_management/views/applicant_management_view.dart
import 'package:defaultx/app/core/widgets/common_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/applicant_model.dart';
import '../controllers/applicant_management_controller.dart';

class ApplicantManagementView extends GetView<ApplicantManagementController> {
  const ApplicantManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(currentPage: 'Applications'),
      // <-- MODIFIED: The entire body structure is updated.
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // The filter bar is now the first widget in the body's Column.
            _buildFilterBar(),
            const SizedBox(height: 16.0),
            // Expanded makes the table take up all remaining vertical space.
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                // The PaginatedDataTable will fill the space provided by Expanded.
                return _buildPaginatedDataTable();
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterBar() {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: TextField(
            controller: controller.searchController,
            decoration: const InputDecoration(
              hintText: 'Search by ID...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
            ),
            onSubmitted: (_) => controller.applyFiltersAndSearch(),
          ),
        ),
        const SizedBox(width: 16),
        Flexible(flex: 1, child: _buildStatusFilterDropdown()),
        const SizedBox(width: 16),
        Flexible(flex: 1, child: _buildLoanTypeFilterDropdown()),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: controller.applyFiltersAndSearch,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Apply Filter'),
        ),
      ],
    );
  }

  Widget _buildStatusFilterDropdown() {
    return Obx(
      () => DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        hint: const Text('All Statuses'),
        value: controller.selectedStatus.value,
        items: [
          const DropdownMenuItem<String>(
            value: null,
            child: Text('All Statuses'),
          ),
          ...controller.statuses.map(
            (status) => DropdownMenuItem(value: status, child: Text(status)),
          ),
        ],
        onChanged: (value) {
          controller.selectedStatus.value = value;
        },
      ),
    );
  }

  Widget _buildLoanTypeFilterDropdown() {
    return Obx(
      () => DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        hint: const Text('All Types'),
        value: controller.selectedLoanType.value,
        items: [
          const DropdownMenuItem<String>(value: null, child: Text('All Types')),
          ...controller.loanTypes.map(
            (type) => DropdownMenuItem(value: type, child: Text(type)),
          ),
        ],
        onChanged: (value) {
          controller.selectedLoanType.value = value;
        },
      ),
    );
  }

  Widget _buildPaginatedDataTable() {
    // This no longer needs a SingleChildScrollView because the PaginatedDataTable
    // handles its own scrolling via pagination, and its height is constrained by Expanded.
    return SizedBox(
      width: double.infinity,
      child: PaginatedDataTable(
        header: const Text('Recent Applicants'),
        rowsPerPage: 10,
        sortColumnIndex: controller.sortColumnIndex.value,
        sortAscending: controller.isAscending.value,
        columns: [
          DataColumn(label: const Text('Loan Type'), onSort: controller.onSort),
          DataColumn(
            label: const Text('Application ID'),
            onSort: controller.onSort,
          ),
          DataColumn(
            label: const Text('Risk Probability (%)'),
            numeric: true,
            onSort: controller.onSort,
          ),
          DataColumn(label: const Text('Status'), onSort: controller.onSort),
        ],
        source: ApplicantDataSource(controller.filteredApplicants),
      ),
    );
  }
}

/// The custom DataTableSource to feed data into the PaginatedDataTable.
class ApplicantDataSource extends DataTableSource {
  final List<Applicant> _applicants;
  ApplicantDataSource(this._applicants);

  @override
  DataRow? getRow(int index) {
    if (index >= _applicants.length) return null;
    final applicant = _applicants[index];

    final riskProbabilityValue = (applicant.extSource2 ?? 0.2) * 50;
    final riskProbabilityString = riskProbabilityValue.toStringAsFixed(0);

    String status;
    if (riskProbabilityValue >= 40) {
      status = 'Defaulter';
    } else if (riskProbabilityValue >= 30 && riskProbabilityValue < 40) {
      status = 'Potential Defaulter';
    } else {
      status = 'Approved';
    }

    return DataRow(
      key: ValueKey(applicant.skIdCurr),
      cells: [
        DataCell(Text(applicant.nameContractType ?? 'N/A')),
        DataCell(Text(applicant.skIdCurr.toString())),
        DataCell(Text('$riskProbabilityString%')),
        DataCell(_buildStatusChip(status)),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => _applicants.length;
  @override
  int get selectedRowCount => 0;

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'Approved':
        color = Colors.green;
        break;
      case 'Potential Defaulter':
        color = Colors.amber;
        break;
      default: // Covers 'Defaulter'
        color = Colors.red;
    }
    return Chip(
      label: Text(status, style: const TextStyle(color: Colors.white)),
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
