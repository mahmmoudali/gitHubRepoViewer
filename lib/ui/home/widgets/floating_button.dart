import 'package:flutter/material.dart';
import 'package:github_repo/providers/main_provider.dart';
import 'package:github_repo/service/repo.dart';
import 'package:github_repo/utils/colors.dart';
import 'package:github_repo/utils/styles.dart';
import 'package:intl/intl.dart';
import 'package:invert_colors/invert_colors.dart';
import 'package:multiselect/multiselect.dart';
import 'package:provider/provider.dart';

class FloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MainProvider mainProvider = Provider.of<MainProvider>(context);

    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(builder: (context, setState) {
                return Dialog(
                  backgroundColor: Colors.transparent,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        color: MColors.primary,
                        borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width - 50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                            child: Text("Filters",
                                style: MStyles.dialogTitleStyle)),
                        SizedBox(height: 10),
                        Text("Select Date", style: MStyles.dialogTitleStyle),
                        SizedBox(height: 5),
                        dateTimePicker(context, setState, mainProvider),
                        SizedBox(height: 10),
                        Text("Number Of Results",
                            style: MStyles.dialogTitleStyle),
                        SizedBox(height: 5),
                        numberOfResultsDropDown(mainProvider, setState),
                        SizedBox(height: 10),
                        Text("Select Languages",
                            style: MStyles.dialogTitleStyle),
                        buildMultiSelectionDropDown(mainProvider),
                        applyButton(context, mainProvider)
                      ],
                    ),
                  ),
                );
              });
            });
      },
      backgroundColor: MColors.titleColor,
      child: Icon(Icons.calendar_today_outlined),
    );
  }

  GestureDetector dateTimePicker(
      BuildContext context, StateSetter setState, MainProvider mainProvider) {
    return GestureDetector(
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.utc(2000),
          lastDate: DateTime.now(),
        ).then((selectedDate) {
          setState(() {
            mainProvider.setSelectedDate(selectedDate!);
          });
        });
      },
      child: Container(
          // margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(color: Colors.grey.withOpacity(.1)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  mainProvider.selectedDate != DateTime.now()
                      ? DateFormat('dd-MM-yyyy')
                          .format(mainProvider.selectedDate)
                          .toString()
                      : "Select Date",
                  style: MStyles.dialogTitleStyle),
              Icon(Icons.calendar_today_outlined, color: MColors.titleColor)
            ],
          )),
    );
  }

  Container numberOfResultsDropDown(
      MainProvider mainProvider, StateSetter setState) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(color: Colors.grey.withOpacity(.1)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: mainProvider.numberOfResults,
          items: ["10", "50", "100"].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: MStyles.dialogTitleStyle),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              mainProvider.setNumberOfResults(value!);
            });
          },
        ),
      ),
    );
  }

  Center applyButton(BuildContext context, MainProvider mainProvider) {
    return Center(
      child: TextButton(
          onPressed: () async {
            Navigator.pop(context);
            mainProvider.setLoading(true);
            RepoService repo = RepoService();
            await repo.getRepoWithSelectedDate(mainProvider).then((repos) {
              mainProvider.setRepos(repos);
            });
          },
          child: Text("Apply", style: MStyles.titleStyle)),
    );
  }

  InvertColors buildMultiSelectionDropDown(MainProvider mainProvider) {
    return InvertColors(
      child: DropDownMultiSelect(
        onChanged: (List<String> x) {
          mainProvider.setLanguages("", []);
          if (x.isNotEmpty)
            x.forEach((element) {
              mainProvider.setLanguages(element, x);
            });
        },
        options: ["C", "Java", "Ruby", "Python"],
        selectedValues: mainProvider.languageList,
        whenEmpty: 'All Languages',
      ),
    );
  }
}
