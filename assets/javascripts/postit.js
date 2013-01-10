/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
// ANY

function message(text, division){

if (0 != jQuery("#message").length) jQuery("#message").remove();

division.prepend("<div id='message' class='message-div ui-widget-content ui-corner-all'>" + text + "</div>");

jQuery("#message").effect('highlight', {}, 4000);
jQuery("#message").hide('highlight', {}, 1000);

}

// Create a localizable datepicker

function localizableDatepicker(fieldid, locale){
  if (locale == "fr"  ) {
      jQuery.datepicker.regional['fr'] = {
		closeText: 'Fermer',
		prevText: '&#x3c;Préc',
		nextText: 'Suiv&#x3e;',
		currentText: 'Courant',
		monthNames: ['Janvier','Février','Mars','Avril','Mai','Juin',
		'Juillet','Août','Septembre','Octobre','Novembre','Décembre'],
		monthNamesShort: ['Jan','Fév','Mar','Avr','Mai','Jun',
		'Jul','Aoû','Sep','Oct','Nov','Déc'],
		dayNames: ['Dimanche','Lundi','Mardi','Mercredi','Jeudi','Vendredi','Samedi'],
		dayNamesShort: ['Dim','Lun','Mar','Mer','Jeu','Ven','Sam'],
		dayNamesMin: ['Di','Lu','Ma','Me','Je','Ve','Sa'],
		weekHeader: 'Sm',
		dateFormat: 'dd/mm/yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};

     jQuery.timepicker.regional['fr'] = {
		timeOnlyTitle: 'Choisir une heure',
		timeText: 'Heure',
		hourText: 'Heures',
		minuteText: 'Minutes',
		secondText: 'Secondes',
		millisecText: 'Millisecondes',
		timezoneText: 'Fuseau horaire',
		currentText: 'Maintenant',
		closeText: 'Terminé',
		timeFormat: 'hh:mm',
		amNames: ['AM', 'A'],
		pmNames: ['PM', 'P'],
		ampm: false
	};

     jQuery.datepicker.setDefaults( jQuery.datepicker.regional["fr"]);
     jQuery.timepicker.setDefaults(jQuery.timepicker.regional['fr']);

  }
  jQuery(fieldid).datetimepicker({altFormat: "mm/dd/yy", dateFormat: 'dd/mm/yy', minDate: new Date(), buttonImage: "/images/calendar.png", showOn: 'both', buttonImageOnly: true});
  
}

// Create multiselect control
function createMultiSelect(fieldid, selecttext){
    jQuery(fieldid).multiselect({noneSelectedText: selecttext, multiple: true, minWidth: 350}).multiselectfilter();
}

// ANY
// Make Postit draggable
function makePostitDraggable(postit_id, url_for_set_position, left_position, top_position){

    jQuery('#draggable' + postit_id).draggable({containment: "body", scroll: false, cursor: "move", handle: ".postit-content" + postit_id,
                                               create: function() {
                                                                   if (left_position == 0  && top_position == 0)
                                                                        {   
                                                                            jQuery('#draggable' + postit_id).css({position: 'absolute', zIndex: 9 + postit_id});
                                                                            jQuery("#draggable" + postit_id).position({my: 'left top', at: 'center bottom', of: '#breadcrumb'});
                                                                        }
                                                                   else
                                                                        {
                                                                         jQuery('#draggable' + postit_id).css({position: 'absolute', zIndex: 9 + postit_id, top: top_position + 'px', left: left_position + 'px'});
                                                                        }
                                                                },
                                               stop: function(event, ui) {jQuery.ajax({
                                                                                        url: url_for_set_position,
                                                                                        data: {id: postit_id, left: ui.position.left, top: ui.position.top, authenticity_token: encodeURIComponent(AUTH_TOKEN)}
                                                                                        })
                                                                         }
                                               });
}

//ANY
// Supprimer les post-it

function removeAllPostits()
{
    if (jQuery("[id^=draggable]").length > 0)
    {var postits = jQuery("[id^=draggable]");
      postits.each(function(p)
                   {jQuery('#' + jQuery(postits[p]).attr('id')).remove();
                   }
                  );
    }
}

//ANY
// Toggle les post-it

function toggleAllPostits(text_hide, text_show)
{var postits = jQuery("[id^=draggable]");
    if (postits.length > 0)
    {jQuery("#postits-toggle-link").hasClass("icon-view-notes") ? jQuery('.postit').css('visibility', 'hidden') : jQuery('.postit').css('visibility', 'visible');
      jQuery("#postits-toggle-link").toggleClass("icon-view-notes icon-hide-notes");
      jQuery("#postits-toggle-link").attr("title",(jQuery("#postits-toggle-link").hasClass("icon-hide-notes") ? text_show : text_hide));
    }
}

// ANY
// Toggle Postit
function toggleNote(note_id, text_hide, text_display)
{
     jQuery('#postit-content'+ note_id).toggle();
     jQuery("#icon-toggle" + note_id).toggleClass("icon-hide icon-display");
     jQuery("#icon-toggle" + note_id).attr("title", (jQuery("#icon-toggle" + note_id).hasClass("icon-hide") ? text_hide : text_display));
}

// ANY
// Close Postit
function closeNote(postit_id){
   jQuery(postit_id).css('visibility','hidden');
}

// ANY
// Create Postit Div
function showPostitsDiv(divid){
  jQuery("#wrapper").append(jQuery(divid));

  if (jQuery('#postit-notes').length > 0) {jQuery('#postit-notes').height(jQuery("#content").height() + 30);jQuery('#postit-notes').width(jQuery("#content").width()/2);}
  
}

// ANY
// Run a note alert 

function runPostitAlert(myurl, id)
{var notes_ids = '';
    var notes = eval(jQuery(id).val());
    if(jQuery.isArray(notes)) notes.each(function(j) {notes_ids += "ids[]=" + j + "&";});

    jQuery.ajax({url: myurl,
                 data: notes_ids});
}

// ANY
function chosenNoteSendToChange(noteid)
{   // Affiche le p de keep_a_copy si la note est en partage
    jQuery(noteid + ' :selected').length > 0 ? jQuery('#lbl_keep_a_copy').show() : jQuery('#lbl_keep_a_copy').hide();

    // Affiche ou cache le p de keep_a_copy au moment du choix des utilisateurs en partage
    jQuery(noteid).unbind().chosen().change(function(){
        if (jQuery(noteid + ' :selected').length > 0)
            {
             jQuery('#note_keep_a_copy').removeAttr('checked');
             jQuery('#lbl_keep_a_copy').show();             
            }
        else
            {
             jQuery('#note_keep_a_copy').attr('checked', 'checked');
             jQuery('#lbl_keep_a_copy').hide();
            }
})
}

