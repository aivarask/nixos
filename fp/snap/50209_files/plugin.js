CKEDITOR.plugins.add('contactform',{    
    init:function(a){       
        var cmd = a.addCommand('contactform', {exec:function(e){
	    e.insertText('[CONTACT_FORM]');
	}});
        cmd.modes={wysiwyg:1,source:1};
        cmd.canUndo=true;
        a.ui.addButton('contactform',{label: a.lang.form.contactForm, command:'contactform', icon:this.path+'images/icon.png'})
    }
})
