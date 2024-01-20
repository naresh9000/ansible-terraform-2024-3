resource "local_file" "inventory-file" {
  content = templatefile("ansible_details.tpl",
    {

      testserver01    = "${aws_instance.web-1.public_ip}"
      testserver02    = "${aws_instance.web-2.public_ip}"
      testserver03    = "${aws_instance.web-3.public_ip}"
      pvttestserver01 = "${aws_instance.web-1.private_ip}"
      pvttestserver02 = "${aws_instance.web-2.private_ip}"
      pvttestserver03 = "${aws_instance.web-3.private_ip}"
    }
  )
  filename = "invfile"


}
